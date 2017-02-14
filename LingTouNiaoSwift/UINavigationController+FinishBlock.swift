//
//  UINavigationController+FinishBlock.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/14.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    var finishBlock: VoidBlock {
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "finishBlock".hashValue)
            let obj: VoidBlock? = objc_getAssociatedObject(self, key) as? VoidBlock
            return obj!
//            return (objc_getAssociatedObject(self, "finishBlock") as! VoidBlock?)!
        }
        set {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "finishBlock".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//            objc_setAssociatedObject(self, "finishBlock", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
