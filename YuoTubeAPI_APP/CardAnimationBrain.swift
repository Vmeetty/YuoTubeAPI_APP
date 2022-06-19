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
    
    private let cardHeight: CGFloat = 700
    private let cardHandleAreaHeight: CGFloat = 50
    
    private var cardVisible = false
    private var nextStep: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    func setupFakeHandle() {
        
    }
    
    func setupCardFor(_ sender: UIViewController) {
        visualEffectView = UIVisualEffectView()
        rootViewController = sender
        
        visualEffectView.frame = rootViewController.view.frame
        visualEffectView.backgroundColor = .red
        rootViewController.view.addSubview(visualEffectView)
        
        cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)
        rootViewController.addChild(cardViewController)
        rootViewController.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: rootViewController.view.frame.height - cardHandleAreaHeight, width: rootViewController.view.bounds.width, height: cardHeight)
        cardViewController.view.layer.cornerRadius = 20
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextStep, duration: 0.9)
        default:
            break
        }
    }
    @objc
    func handleCardPan(recognizer: UIPanGestureRecognizer) {
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
//        switch state {
//        case .expanded:
//            print("expanded")
//        case .collapsed:
//            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//                self.banerViewController.view.removeFromSuperview()
//            }
//        }
        
    }
    
}

