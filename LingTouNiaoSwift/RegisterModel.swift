//
//  RegisterModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/7.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class RegisterModel: NSObject {
    
    class func getMessageCode(params: Dictionary<String, Any>, block: @escaping responseBlock) {
        NetAPIManager.sharedManager.request(path: GetMobileCaptchaUrl, params: params, methodType: NetworkMethod.Get, block: block)
    }
    
    class func userRegister(params: Dictionary<String, Any>, block: @escaping responseBlock) {
        
    }
}
