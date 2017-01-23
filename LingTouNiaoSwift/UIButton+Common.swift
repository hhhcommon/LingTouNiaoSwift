//
//  UIButton+Common.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/9.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

typealias TappedBlock = ((UIButton) -> ())

extension UIButton {
    
    var tappedBlock : TappedBlock {
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "tappedBlock".hashValue)
            let obj: TappedBlock? = objc_getAssociatedObject(self, key) as? TappedBlock
            return obj!
        }
        set {
            self.addTarget(self, action: #selector(tapButton(button:)), for: UIControlEvents.touchUpInside)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "tappedBlock".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func tapButton(button: UIButton) {
//        if self.tappedBlock != nil {
            self.tappedBlock(button)
//        }
    }

    // 背景颜色
    func setBackgroundColor(disenableColor: UIColor, enableColor: UIColor) {
        self.setBackgroundImage(UIImage.imageWithColor(color: MainColor), for: UIControlState.normal)
        self.setBackgroundImage(UIImage.imageWithColor(color: DisabledColor), for: UIControlState.disabled)
    }
    
    // 按钮创建
    class func createButton(nomalIconName: String, selectedIconName: String, block: @escaping TappedBlock) -> UIButton {
        let button = UIButton.createButton(iconName: nomalIconName, block: block)
        button.setImage(UIImage.init(named: selectedIconName), for: .selected)
        return button
    }
    class func createButton(iconName: String, block: @escaping TappedBlock) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(named: iconName), for: .normal)
        button.tappedBlock = block
        return button
    }
    class func createButton(title: String, color: UIColor, font: UIFont, block: @escaping TappedBlock) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        button.sizeToFit()
        button.tappedBlock = block
        return button
    }
}
