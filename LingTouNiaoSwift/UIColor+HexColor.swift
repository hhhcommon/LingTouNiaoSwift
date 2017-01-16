//
//  UIColor+HexColor.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

extension UIColor {
    
    // string -> color
    // 默认alpha值为1
    class func colorWithHexString(hexString: String) -> UIColor {
        return UIColor.colorWithHexStringAndAlpha(hexString: hexString, alpha: CGFloat(1.0))
    }
    class func colorWithHexStringAndAlpha(hexString: String, alpha: CGFloat) -> UIColor {
        var color = UIColor.clear
        // 删除字符串中的空格
        var cString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 字符串应该是6－8个字符
        if cString.characters.count < 6 {
            return color
        }
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if cString.hasPrefix("0x") || cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        // 截取字符串后，正确的字符串应该是6个字符
        if cString.characters.count != 6 {
            return color
        }
        // 将字符串拆分成r, g, b三个子字符串
        var myStartIndex = cString.startIndex
        var myEndIndex = cString.index(cString.startIndex, offsetBy: 2)

        let range = Range(uncheckedBounds: (lower: myStartIndex, upper: myEndIndex))
        //r
        let rString = cString.substring(with: range)
        //g
        myStartIndex = myEndIndex;
        myEndIndex = cString.index(myStartIndex, offsetBy: 2)
        let gString = cString.substring(with: range)
        //b
        myStartIndex = myEndIndex;
        myEndIndex = cString.index(myStartIndex, offsetBy: 2)
        let bString = cString.substring(with: range)
        color = UIColor.init(colorLiteralRed: Float(color.changeToInt(numStr: rString)) / 255, green: Float(color.changeToInt(numStr: gString)) / 255, blue: Float(color.changeToInt(numStr: bString)) / 255, alpha: 1)
        return color
    }
    
    // uint -> color
    class func colorWithHexAndAlpha(hex:UInt32, alpha:CGFloat) -> UIColor {
        let b = hex & 0x0000FF
        let g = ((hex & 0x00FF00) >> 8)
        let r = ((hex & 0xFF0000) >> 16)
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
    }
    class func colorWithHex(hex : UInt32) -> UIColor {
        return UIColor.colorWithHexAndAlpha(hex: hex, alpha: CGFloat(1.0))
    }
    
    // r, g, b, a -> color
    class func colorWithRGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, a:CGFloat) -> UIColor { return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    class func colorWithRGB(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    fileprivate func changeToInt(numStr: String) -> Int {
        
        let str = numStr.uppercased()
        var sum = 0
        for i in str.utf8 {
            //0-9 从48开始
            sum = sum * 16 + Int(i) - 48
            if i >= 65 {
                //A~Z 从65开始，但初始值为10
                sum -= 7
            }
        }  
        return sum
    }
}
