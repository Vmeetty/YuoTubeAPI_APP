//
//  CardAnimationBrain.swift
//  YuoTubeAPI_APP
//
//  Created by user on 18.06.2022.
//

import Foundation
import UIKit

class CardAnimationBrain {
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    static var shared = CardAnimationBrain()
    
    private var visualEffectView: UIVisualEffectView!
    
    private var cardViewController: CardViewController!
    private var rootViewController: UIViewController!
    
    private let cardHeight: CGFloat = 650
    private let cardHandleAreaHeight: CGFloat = 65
    private let handleViewCornerRadius: CGFloat = 20
    private let handleWidth = 45
    private var handleViewFrame: CGRect!
    
    private var cardVisible = false
    private var nextStep: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    private let fakeHandleView: UIView = {
        let handleView = UIView()
        handleView.backgroundColor = K.Colors.firstColor
        handleView.clipsToBounds = true
        return handleView
    }()
    
    let iconImageView: UIImageView = {
        let iconImage = UIImage(named: "up-arrow")
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.image = iconImage
        return imageView
    }()
    
    
    func setupFakeHandleView(_ sender: UIViewController) {
        
        rootViewController = sender
        
        fakeHandleView.frame = CGRect(x: 0, y: rootViewController.view.frame.height - cardHandleAreaHeight, width: rootViewController.view.bounds.width, height: cardHeight)
        fakeHandleView.layer.cornerRadius = handleViewCornerRadius
        rootViewController.view.addSubview(fakeHandleView)
        
        iconImageView.frame = CGRect(x: (Int(fakeHandleView.bounds.width) / 2) - Int(handleWidth / 2), y: 5, width: handleWidth, height: 30)
        fakeHandleView.addSubview(iconImageView)

        fakeGestureConfig()
        configCardView()
    }
 
    
    //MARK: - Preparing for handling
    @objc
    func fakeHandleViewTapt(recognizer: UITapGestureRecognizer) {
        setupCardView()
        handleTap(recognizer: recognizer)
    }
    
    @objc
    func fakeHandleViewPan(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer: recognizer)
    }
    
    private func configCardView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = rootViewController.view.frame
        
        cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)
        cardViewController.view.frame = CGRect(x: 0, y: rootViewController.view.frame.height - cardHandleAreaHeight, width: rootViewController.view.bounds.width, height: cardHeight)
        cardViewController.view.layer.cornerRadius = handleViewCornerRadius
        cardViewController.view.clipsToBounds = true
        
        gradientConfig()
        cardGestureConfig()
    }
    
    private func fakeGestureConfig() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fakeHandleViewTapt(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(fakeHandleViewPan(recognizer:)))
        fakeHandleView.addGestureRecognizer(tapGestureRecognizer)
        fakeHandleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func cardGestureConfig() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func gradientConfig() {
        let gradient = CAGradientLayer()
        gradient.frame = cardViewController.view.bounds
        gradient.colors = [K.Colors.firstColor.cgColor, K.Colors.secondColor.cgColor]
        cardViewController.containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupCardView() {
        rootViewController.view.addSubview(visualEffectView)
        rootViewController.addChild(cardViewController)
        rootViewController.view.addSubview(cardViewController.view)
    }
    
    private func removeCardController() {
        if nextStep == .collapsed {
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
                self.visualEffectView.removeFromSuperview()
                self.cardViewController.view.removeFromSuperview()
                self.cardViewController.removeFromParent()
            }
        }
    }
    
    @objc
    func handleCardTap(recognizer: UITapGestureRecognizer) {
        handleTap(recognizer: recognizer)
    }
    
    @objc
    func handleCardPan(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer: recognizer)
    }
    
    
    //MARK: - Handling gestures
    private func handleTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextStep, duration: 0.9)
            removeCardController()
        default:
            break
        }
    }
    
    private func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            switch nextStep {
            case .expanded:
                setupCardView()
            default:
                break
            }
            startInteractiveTransition(state: nextStep, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateIntarectiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractionTransition()
        default: break
        }
    }
    
    
    //MARK: - Animation
    
    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.rootViewController.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.rootViewController.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateIntarectiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractionTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
        removeCardController()
    }
}

