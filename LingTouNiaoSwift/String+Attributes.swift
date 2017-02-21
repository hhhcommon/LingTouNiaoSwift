//
//  String+Attributes.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

extension String {
    
    func configAttributesForString(attributes: Dictionary<String, Any>, string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        var temp: String?
        for i in 0..<self.characters.count {
            if i + string.characters.count > self.characters.count {
                break
            }
            let startIndex = self.index(self.startIndex, offsetBy: i)
            let endIndex = self.index(startIndex, offsetBy: string.characters.count)
            temp = self.substring(with: Range(uncheckedBounds: (lower: startIndex, upper: endIndex)))
            if temp != nil && temp == string {
                attributedString.addAttributes(attributes, range: NSMakeRange(i, string.characters.count))
            }
        }
        return attributedString
    }
    
    func configAttributesWithFontSizeForString(fontSize: CGFloat, string: String) -> NSAttributedString {
        let attributes = [NSFontAttributeName : normalFont(fontSize)]
        return self.configAttributesForString(attributes: attributes, string: string)
    }
    
    func configAttributesForStringArray(attributes: Dictionary<String, Any>, stringArray: Array<String>) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for i in 0..<stringArray.count {
            let string = stringArray[i]
            var temp: String?
            for j in 0..<self.characters.count {
                if j + string.characters.count > self.characters.count {
                    break
                }
                let startIndex = self.index(self.startIndex, offsetBy: j)
                let endIndex = self.index(startIndex, offsetBy: string.characters.count)
                temp = self.substring(with: Range(uncheckedBounds: (lower: startIndex, upper: endIndex)))
                if temp != nil && temp == string {
                    attributedString.addAttributes(attributes, range: NSMakeRange(j, string.characters.count))
                }
            }
        }
        return attributedString
    }
    
    func configAttributesWithFontSizeForStringArray(fontSize: CGFloat, stringArray: Array<String>) -> NSAttributedString {
        let attributes = [NSFontAttributeName : normalFont(fontSize)]
        return self.configAttributesForStringArray(attributes: attributes, stringArray: stringArray)
    }
    
    func configAttributesArrayForStringArray(attributesArray: Array<Dictionary<String, Any>>, stringArray: Array<Any>) -> NSAttributedString {
        
        if attributesArray.count != stringArray.count {
            return NSAttributedString(string: self)
        }
        
        let attributedString = NSMutableAttributedString(string: self)
        for i in 0..<stringArray.count {
            let string: String = stringArray[i] as! String
            let attributes: Dictionary<String, Any> = attributesArray[i]
            var temp: String?
            for j in 0..<self.characters.count {
                if j + string.characters.count > self.characters.count {
                    break
                }
                let startIndex = self.index(self.startIndex, offsetBy: j)
                let endIndex = self.index(startIndex, offsetBy: string.characters.count)
                temp = self.substring(with: Range(uncheckedBounds: (lower: startIndex, upper: endIndex)))
                if temp != nil && temp == string {
                    attributedString.addAttributes(attributes, range: NSMakeRange(j, string.characters.count))
                }
            }
        }
        return attributedString
    }
}
