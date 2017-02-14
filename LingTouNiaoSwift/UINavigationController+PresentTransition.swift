//
//  UINavigationController+PresentTransition.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/14.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

extension UINavigationController: UIViewControllerTransitioningDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        let systemVersion = NSString(string: UIDevice.current.systemVersion)
        if systemVersion.floatValue >= 8.0 {
            self.transitioningDelegate = self
            self.modalPresentationStyle = UIModalPresentationStyle.custom
        }
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition.transition(type: PresentTransitionType.TransitionPresent, duration: 0.5)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition.transition(type: PresentTransitionType.TransitionDismiss, duration: 0.5)
    }
}
