//
//  CustomButton.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/9.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            if self.layer.borderWidth > 0 {
            self.layer.borderColor = newValue ? MainColor.cgColor : DisabledColor.cgColor
            }
        }
    }
    
    // 带背景色的圆角button
    class func createBGButtonWithCorner(title: String, actionBlock: @escaping TappedBlock) -> CustomButton {
        let button = CustomButton.createBGButton(title: title, actionBlock: actionBlock)
        button.layer.cornerRadius = 2.5
        button.layer.masksToBounds = true
        return button
    }
    
    // 带背景色的button
    class func createBGButton(title: String, actionBlock: @escaping TappedBlock) -> CustomButton {
        let button = CustomButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = normalFont(18)
        button.sizeToFit()
        button.tappedBlock = actionBlock
        button.setBackgroundColor(disenableColor: DisabledColor, enableColor: MainColor)
        return button
    }
    
    // 带圆角的描边button
    class func createBorderButtonWithCorner(title: String, actionBlock: @escaping TappedBlock) -> CustomButton {
        let button = CustomButton.createBorderButton(title: title, actionBlock: actionBlock)
        button.layer.cornerRadius = 2.5
        button.layer.masksToBounds = true
        return button
    }
    
    // 描边button
    class func createBorderButton(title: String, actionBlock: @escaping TappedBlock) -> CustomButton {
        let button = CustomButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(MainColor, for: .normal)
        button.titleLabel?.font = normalFont(18)
        button.sizeToFit()
        button.tappedBlock = actionBlock
        button.setTitleColor(UIColor.white, for: UIControlState.selected)
        button.setTitleColor(DisabledColor, for: UIControlState.disabled)
        button.layer.borderWidth = LineThick
        
        return button
    }
}
