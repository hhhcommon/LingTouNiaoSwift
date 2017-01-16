//
//  LoginController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class LoginController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.showCloseButton(isShow: true)
        baseNavigationController?.hideBorder(isHidden: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarItem(title: "注册", target: self, action: #selector(LoginController.registerSubmit), color: UIColor.colorWithHex(hex: 0x3a3a3a))
        let loginView = LoginView()
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func registerSubmit() {
        print("register")
        let registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
//    fileprivate func loginSubmit(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
}
