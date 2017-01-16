//
//  HomeRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class HomeRootController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        let loginButton = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: GeneralSize))
        loginButton.setTitle("登录", for: UIControlState.normal)
        loginButton.backgroundColor = UIColor.orange
        loginButton.addTarget(self, action: #selector(HomeRootController.login), for: UIControlEvents.touchUpInside)
        view.addSubview(loginButton)
    }
    
    func login() {
        print("login")
        let loginNav = BaseNavigationController(rootViewController: LoginController())
        self.present(loginNav, animated: true) {
            
        }
    }
}
