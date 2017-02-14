//
//  PresentTransition.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/14.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

enum PresentTransitionType {
    case TransitionPresent
    case TransitionDismiss
}

class PresentTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var type: PresentTransitionType?
    var duration: TimeInterval = 0.0
    
    class func transition(type: PresentTransitionType, duration: TimeInterval) -> PresentTransition {
        let transition = PresentTransition()
        transition.type = type
        transition.duration = duration
        return transition
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if type != nil {
            switch type! {
            case .TransitionPresent:
                self.present(transitonContext: transitionContext)
            case .TransitionDismiss:
                self.dismiss(transitonContext: transitionContext)
            }
        }
    }
    
    // MARK: - Private
    func present(transitonContext: UIViewControllerContextTransitioning) {
        let toVC = transitonContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let finalFrame = transitonContext.finalFrame(for: toVC!)
        let containerView = transitonContext.containerView
        // fromVC.view.hidden = YES;
        let screenBounds = UIScreen.main.bounds
        containerView.addSubview((toVC?.view)!)
        toVC?.view.frame = finalFrame.offsetBy(dx: screenBounds.size.width, dy: 0)
        
        let duration = self.transitionDuration(using: transitonContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
            toVC?.view.frame = finalFrame
        }) { (finished) in
            transitonContext.completeTransition(true)
        }
    }
    
    func dismiss(transitonContext: UIViewControllerContextTransitioning) {
        
        // 1. Get controllers from transition context
        let fromVC = transitonContext.viewController(forKey: UITransitionContextViewControllerKey.from)
//        let toVC =  transitonContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        // 2. Set init frame for fromVC
        let screenBounds = UIScreen.main.bounds
        let initFrame = transitonContext.initialFrame(for: fromVC!)
        let finalFrame = initFrame.offsetBy(dx: screenBounds.size.width, dy: 0)
        
        // 3. Add target view to the container, and move it to back.
        _ = transitonContext.containerView
        // [containerView addSubview:toVC.view];
        // [containerView sendSubviewToBack:toVC.view];
        
        // 4. Do animate now
        let duration = self.transitionDuration(using: transitonContext)
        
        UIView.animate(withDuration: duration, animations: { 
            fromVC?.view.frame = finalFrame
        }) { (finished) in
            transitonContext.completeTransition(!transitonContext.transitionWasCancelled)
        }
    }
}
