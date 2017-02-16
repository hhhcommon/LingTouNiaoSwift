//
//  BaseViewController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var baseNavigationController: BaseNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false;
        automaticallyAdjustsScrollViewInsets = false;
        if (navigationController is BaseNavigationController) {
            baseNavigationController = navigationController as? BaseNavigationController
        }
        view.backgroundColor = BackgroundColor
        self.showCloseButton(isShow: false)
        self.showBackButton(isShow: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// NavigationButton
extension BaseViewController {
    func showBackButton(isShow: Bool) {
        if isShow && navigationController != nil && (navigationController?.childViewControllers.count)! > 1 {
            let backButton = UIBarButtonItem.createBarItem(image: UIImage.init(named: "nav_return")!, target: self, action: #selector(BaseViewController.back))
            navigationItem.leftBarButtonItem = backButton;
        } else {
            navigationItem.leftBarButtonItem = nil;
        }
    }
    
    func showCloseButton(isShow: Bool) {
        if (isShow && navigationController != nil && navigationController?.childViewControllers.count == 1) {
            let closeButton = UIBarButtonItem.createBarItem(image: UIImage.init(named: "nav_close")!, target: self, action: #selector(BaseViewController.back))
            self.navigationItem.leftBarButtonItem = closeButton;
        } else {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
    
    func back() {
        if (navigationController?.visibleViewController == self) {
            _ = navigationController?.popViewController(animated: true)
        }
        if ((self.presentingViewController) != nil) {
            self.dismiss(animated: true, completion: { 
                
            })
        }
    }
}
