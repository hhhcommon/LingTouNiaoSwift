//
//  CustomerizedFont.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/30.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class CustomerizedFont: UIFont {

    let DeviceiPhone6plusWidth: CGFloat = 375
    let IsIOS9: Bool = Double(UIDevice.current.systemVersion)! > 8.9
    
    class func systemFontOfSize(fontSize: CGFloat) -> UIFont {
        return self.heiti(fontSize: fontSize)
    }
    
    class func boldSystemFontOfSize(fontSize: CGFloat) -> UIFont {
        return self.boldHeiti(fontSize: fontSize)
    }
    
    fileprivate func fontWithSize(fontSize: CGFloat) -> UIFont {
        if ScreenWidth > DeviceiPhone6plusWidth {
            return super.withSize(fontSize + 2)
        } else {
            return super.withSize(fontSize)
        }
    }
    
    class func resetSystemFontOfSize(fontSize: CGFloat) -> UIFont {
        return self.heiti(fontSize: fontSize)
    }
    
    class func resetBoldSystemFontOfSize(fontSize: CGFloat) -> UIFont {
        return self.boldHeiti(fontSize: fontSize)
    }
    
    //ios9系统字体为平方PingFangSC，ios9以下的字体为STHeitiSC 类似系统
    class func heiti(fontSize: CGFloat) -> UIFont {
        
        if Double(UIDevice.current.systemVersion)! > 8.9 {
            return UIFont.init(name: "PingFangSC-Light", size: fontSize)!
        } else {
            return UIFont.init(name: "STHeitiSC-Light", size: fontSize)!
        }
    }
    
    class func boldHeiti(fontSize: CGFloat) -> UIFont {
        if Double(UIDevice.current.systemVersion)! > 8.9 {
            return UIFont.init(name: "PingFangSC-Medium", size: fontSize)!
        } else {
            return UIFont.init(name: "STHeitiSC-Medium", size: fontSize)!
        }
    }
    
    class func heitiLightWithSize(fontSize: CGFloat) -> UIFont {
        return self.heiti(fontSize: fontSize)
    }
    
    class func boldHeitiWithSize(fontSize: CGFloat) -> UIFont {
        return self.boldHeiti(fontSize: fontSize)
    }
}
