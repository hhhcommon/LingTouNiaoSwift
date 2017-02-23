//
//  BaseModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import MJExtension

class BaseModel: NSObject, NSCoding {
    
    override init() {
        super.init()
        BaseModel.mj_referenceReplacedKey(whenCreatingKeyValues: true)
    }
    
    override func mj_newValue(fromOldValue oldValue: Any!, property: MJProperty!) -> Any! {
        if oldValue == nil && property.type.typeClass is String.Type {
            return ""
        }
        return oldValue
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        if key == "totalCount" {
            return 0
        }
        return nil
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init()
        self.mj_decode(aDecoder)
    }
    
    func encode(with aCoder:NSCoder) {
        self.mj_encode(aCoder)
    }
    
//    - (id)initWithCoder:(NSCoder *)decoder \
//    {
//    if (self = [super init]) {
//    [self mj_decode:decoder];
//    }
//    return self;
//    }
//    \
//    - (void)encodeWithCoder:(NSCoder *)encoder \
//    { \
//    [self mj_encode:encoder]; \
//    }
}
