//
//  UILabel+Common.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 2017/5/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

extension UILabel {
    class func createLabel(text: String, color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        label.sizeToFit()
        return label
    }
    
    class func createLabel(color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel.createLabel(text: "", color: color, font: font)
        return label
    }
    
    class func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel.createLabel(text: text, color: UIColor.black, font: font)
        return label
    }
    
    class func createLabel(text: String) -> UILabel {
        let label = UILabel.createLabel(text: text, color: UIColor.black, font: normalFont(16))
        return label
    }
}
