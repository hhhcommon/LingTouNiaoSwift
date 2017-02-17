//
//  CurrentUser.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/13.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class CurrentUser: UserModel {
    
    // 用户sessionKey
    var sessionKey: String?
    
    static let mine = CurrentUser()
    private override init() {
        super.init()
        let sessionKey = UserDefaults.standard.value(forKey: SessionKey) as? String
        if sessionKey != nil && !(sessionKey?.isEmpty)! {
            self.sessionKey = sessionKey
        } else {
            self.sessionKey = ""
        }
    }
    
    //是否登录
    func hasLogged() -> Bool {
        return (sessionKey?.isEmpty)! ? false : true
    }
    
    //退出登陆调用
    func reset() {
        UserDefaults.standard.removeObject(forKey: SessionKey)
        UserDefaults.standard.removeObject(forKey: MobileNo)
        UserDefaults.standard.synchronize()
        /* Clear cookies */
        GlobalManager.deleteAllHTTPCookies()
        //        [NetDataCacheManager resetCache];
//        mine = nil;
//        [[self class] mine];
    }
    
    class func loginSuccess(sessionKey: String) {
        //    [NetDataCacheManager resetCache];
        CurrentUser.mine.sessionKey = sessionKey
        UserDefaults.standard.set(sessionKey, forKey: SessionKey)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LoginSuccessNotification), object: nil, userInfo: nil)
    }
}

extension CurrentUser {
    
}
