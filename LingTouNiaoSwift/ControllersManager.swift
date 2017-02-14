//
//  ControllersManager.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/30.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

typealias VoidBlock = ((Void) -> Void)

class ControllersManager: NSObject {
    static let shared = ControllersManager()
    private override init() {}
    
    var progectRootController: ProgectRootController?
    func setupProjectRootViewController() {
        let progectRootController = ProgectRootController()
        GlobalManager.mainWindow().rootViewController = progectRootController
        self.progectRootController = progectRootController
    }
    
    // MARK: - about user
    func logout() {
        CurrentUser.mine.reset()
        self.setupProjectRootViewController()
    }
    
    func actionWhenLogin(finishBlock: VoidBlock?) {
        if CurrentUser.mine.hasLogged() {
            // 如果用户已经登录
            finishBlock?()
        } else {
            // 如果用户未登录，跳转到登录页面
            self.loginController(finishBlock: finishBlock)
        }
    }
    
    func loginController(finishBlock: VoidBlock?) {
        let loginController = LoginController()
        let loginNavi = BaseNavigationController(rootViewController: loginController)
        if finishBlock != nil {
            loginNavi.finishBlock = finishBlock!
        }
        progectRootController?.present(loginNavi, animated: true, completion:nil)
    }
}

