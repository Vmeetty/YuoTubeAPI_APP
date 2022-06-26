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
    
    var videos: [VideoModel]?
    
    var cardViewController: CardViewController!
    private var rootViewController: UIViewController!
    
    var tapRecognizer: UITapGestureRecognizer!
    
    
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
    
    
    //MARK: - CardView init
    
    func configCardView(_ sender: UIViewController) {
        if cardViewController != nil {
            cardViewController.view.removeFromSuperview()
            cardViewController.removeFromParent()
        }
        rootViewController = sender
        
        cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)
        cardViewController.view.frame = CGRect(x: 0, y: rootViewController.view.frame.height - cardHandleAreaHeight, width: rootViewController.view.bounds.width, height: cardHeight)
        cardViewController.view.layer.cornerRadius = handleViewCornerRadius
        cardViewController.view.clipsToBounds = true
        
        rootViewController.addChild(cardViewController)
        rootViewController.view.addSubview(cardViewController.view)
        
        gradientConfig()
        cardGestureConfig()
    }
    
    
    private func gradientConfig() {
        let gradient = CAGradientLayer()
        gradient.frame = cardViewController.view.bounds
        gradient.colors = [K.Colors.firstColor.cgColor, K.Colors.secondColor.cgColor]
        cardViewController.containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func cardGestureConfig() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        cardViewController.handleArea.addGestureRecognizer(tapRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardTap() {
        handleTap()
    }
    
    @objc
    func handleCardPan(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer: recognizer)
    }
    
    
    //MARK: - Set the video model data to cardViewcontroller and updateUI
    func setVideoToCardVC(videos: [VideoModel], at index: Int) {
        cardViewController.updateUI(videos: videos, at: index)
        handleTap()
    }
    
    //MARK: - Handling gestures
    
    func handleTap() {
        animateTransitionIfNeeded(state: nextStep, duration: 0.9)
        
//        switch tapRecognizer.state {
//        case .ended:
//            animateTransitionIfNeeded(state: nextStep, duration: 0.9)
//        default:
//            animateTransitionIfNeeded(state: nextStep, duration: 0.9)
//        }
    }
    
    private func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
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
    }
}

