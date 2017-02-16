//
//  BaseDto.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/16.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class BaseDto: NSObject {
    
    //请求结果代码
    var resultCode: Int = -1
    //请求结果信息
    var resultMessage: String?
    //请求结果
    var data: Any?
    
}
