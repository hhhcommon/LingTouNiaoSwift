//
//  String+Check.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/22.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import Foundation

extension String {
    // MARK: 正则匹配手机号
    static func isPhoneNumber(string: String) -> Bool {
        let telRegex = "^1[34578]\\d{9}$"
        let prediate = NSPredicate(format: "SELF MATCHES %@", telRegex)
        return prediate.evaluate(with: string)
    }

    // MARK: 正则匹配用户身份证号18位
    static func isUserIdCard(string: String) -> Bool {
        // 正则匹配用户身份证号15或18位
        //    NSString * idCard = @"(^[0+9]{15}$)|([0+9]{17}([0+9]|X)$)";
        // 正则匹配用户身份证号18位
        let idCard = "[0+9]{17}([0+9]|X|x)$"
        let prediate = NSPredicate(format: "SELF MATCHES %@", idCard)
        return prediate.evaluate(with: string)
    }
    
    // MARK: 18位身份证号码校验
    static func isValidIDCardNumber(string: String) -> Bool {
        let cardNo = string
        if cardNo.characters.count != 18 {
            return false
        }
        let codeArray:[String] = ["7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2"]
        let checkCodeDic:[String : String] = ["0" : "1", "1" : "0", "2" : "X", "3" : "9", "4" : "8", "5" : "7", "6" : "6", "7" : "5", "8" : "4", "9" : "3", "10" : "2"]

        let scan = Scanner(string: cardNo.substring(to: string.index(before: string.endIndex)))
//        NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
        
        var val: Int = 0
        let isNum = scan.scanInt(&val) && scan.isAtEnd
        if !isNum {
            return false
        }
        var sumValue = 0
        for i in 0..<17 {
            let startIndex = cardNo.index(cardNo.startIndex, offsetBy: i)
            let endIndex = cardNo.index(cardNo.startIndex, offsetBy: i+1)
            let range = startIndex..<endIndex
            sumValue += Int(cardNo.substring(with: range))! * Int(codeArray[i])!
        }
        
        let strlast = checkCodeDic["\(sumValue % 11)"]
        let startIndex = cardNo.index(before: cardNo.endIndex)
        let endIndex = cardNo.endIndex
        let range = startIndex..<endIndex
        if strlast == cardNo.substring(with: range).uppercased() {
            return true
        }
        return false
    }
    
    // MARK: 正则匹配用户密码6+18位数字和字母组合
    static func isPassword(string: String) -> Bool {
        let password = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$"
        let prediate = NSPredicate(format: "SELF MATCHES %@", password)
        return prediate.evaluate(with: string)
    }
    
    // MARK: 判断是否为两位小数
    static func isValidDecimal(string: String) -> Bool {
        if string.contains(".") {
            let digitArray = string.components(separatedBy: ".")
            let decimalPart = digitArray.last
            return (decimalPart?.characters.count)! > 2 ? false : true
        }
        return true
    }
    
    // MARK: 判断是否为整数
    static func isPureInterger(string: String) -> Bool {
        let scan = Scanner(string: string)
        var val: Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    // MARK: 判断是否为float型
    static func isPureFloat(string: String) -> Bool {
        let scan = Scanner(string: string)
        var val: Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    // MARK: 判断是否为double型
    static func isPureDouble(string: String) -> Bool {
        let scan = Scanner(string: string)
        var val: Double = 0
        return scan.scanDouble(&val) && scan.isAtEnd
    }
    
    // MARK: 判断是否为纯数字
    static func isPureNumericCharacters(string: String) -> Bool {
        let str = string.trimmingCharacters(in: CharacterSet.decimalDigits)
        return str.characters.count > 0 ? false : true
    }
    
    // MARK: 判断是否为邮箱
    static func isValidEmail(string: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let prediate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return prediate.evaluate(with: string)
    }
    
    // MARK: 判断字符串是否为有效名字
    static func isValidName(string: String) -> Bool {
        let nickNameRegex = "^([\u{4e00}-\u{9fa5}]{0,10})$"
        let prediate = NSPredicate(format: "SELF MATCHES %@", nickNameRegex)
        return prediate.evaluate(with: string.trimSpaces())
    }
}
