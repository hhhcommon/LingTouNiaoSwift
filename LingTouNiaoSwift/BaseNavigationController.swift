//
//  BaseNavigationController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var navigationBottomLine = UIView()
    
    var barBackgroundColor: UIColor {
        get {
            return self.barBackgroundColor
        }
        set {
            navigationBar.setBackgroundImage(UIImage.imageWithColor(color: newValue), for: UIBarMetrics.default)
        }  
    }
    var borderColor: UIColor {
        get {
            return self.borderColor
        }
        set {
            navigationBottomLine.backgroundColor = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        barBackgroundColor = NavigationBarColor
        borderColor = LineColor
        navigationBottomLine.frame = CGRect(x: 0, y: GeneralSize, width: ScreenWidth, height: LineThick)
        navigationBottomLine.backgroundColor = LineColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //藏旧
        self.hideBorderInView(navigationBar)
        //添新
        navigationBar.addSubview(navigationBottomLine)
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController?
    {
        return self.topViewController
    }
    
    // 查找系统navigationbar底部线条并隐藏
    fileprivate func hideBorderInView(_ view: UIView) {
        if view is UIImageView && view.frame.size.height <= 1 {
            view.isHidden = true
        }
        for subView in view.subviews {
            self.hideBorderInView(subView)
        }
    }
    
    // 隐藏自定义底部线条
    func hideBorder(isHidden: Bool) {
        navigationBottomLine.isHidden = isHidden
    }
}
