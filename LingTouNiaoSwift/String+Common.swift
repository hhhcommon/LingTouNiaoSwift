//
//  String+Common.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/17.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import Foundation

extension String {
    // 加密
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: digestLen)
        return String(format: hash as String)
    }
    
    // 字典－>字符串(序列化)
    static func serialize(dict: Dictionary<String, Any>) -> String {
        let sortedValues = dict.keys.sorted()
        if sortedValues.count == 0 {
            return ""
        }
        var inputString = ""
        for key in sortedValues {
            inputString = inputString + "\(key)=\(dict[key])"
        }
        return inputString
    }
    
    func netAbsolutePath() -> String {
        var fullPath = self
        if !self.hasPrefix("http") {
            fullPath = API_BASE_URL + self
        }
        return fullPath
    }
    
    // 文本格式化,去掉空格
    func trimSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }

}
