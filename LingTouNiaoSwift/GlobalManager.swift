//
//  GlobalManager.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/30.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import IQKeyboardManagerSwift

class GlobalManager: NSObject {
    static let shared = GlobalManager()
    private override init() {}
    
    class func globleSetting() {
        // 键盘
        self.initIQKeyboardManager()
        // 显示
        self.initializeGlobleApprence()
    }
    
    class fileprivate func initIQKeyboardManager() {
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 40
        IQKeyboardManager.sharedManager().enable = true
    }
    
    class fileprivate func initializeGlobleApprence() {
        // tab bar
        UITabBar.appearance().tintColor = MainColor
        
        //navigation bar
        let attributes: Dictionary<String, NSObject> = [NSFontAttributeName : CustomerizedFont.heiti(fontSize: 20), NSForegroundColorAttributeName : Color333333]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().barTintColor = NavigationBarColor
    }
    
    // app 相关
    class func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func mainWindow() -> UIWindow {
        return self.appDelegate().window!
    }
    
    class func keyWindow() -> UIWindow {
        return UIApplication.shared.keyWindow!
    }
    
    class func appRootViewController() -> UIViewController {
        return self.mainWindow().rootViewController!
    }
    
    class func appVersion() -> String {
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        return version as! String;
    }
    
    class func buildVersion() -> String {
        let version = Bundle.main.infoDictionary!["CFBundleVersion"]
        return version as! String
    }
    
    class func displayName() -> String {
        let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"]
        return displayName as! String
    }
    
    class func appDownloadUrl() -> String {
        // todo:
        return ""
    }
    
    class func deleteAllHTTPCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in cookieStorage.cookies! {
            cookieStorage.deleteCookie(cookie)
        }
        URLCache.shared.removeAllCachedResponses()
    }
}
