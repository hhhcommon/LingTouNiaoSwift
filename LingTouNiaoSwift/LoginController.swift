//
//  LoginController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class LoginController: BaseViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.showCloseButton(isShow: true)
        baseNavigationController?.hideBorder(isHidden: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarItem(title: "注册", target: self, action: #selector(self.registerSubmit), color: UIColor.colorWithHex(hex: 0x3a3a3a))
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        loginView.loginSubmitBlock = { (button) in
            self.loginSubmit(button)
        }
        
        loginView.getCaptchaBlock = { (button) in
            self.getCaptchaSubmit(button)
        }
    }
    
    @objc fileprivate func registerSubmit() {
        print("register")
        let registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    fileprivate func getCaptchaSubmit(_ button: UIButton) {
        print("获取验证码")
        button.isEnabled = false
        LoginModel.getPictureCode { (image) in
            button.isEnabled = true
            if image != nil {
                self.loginView.captchaButton?.setImage(image!, for: UIControlState.normal)
            }
        }
    }
    
    fileprivate func loginSubmit(_ button: UIButton) {
        if !String.isPhoneNumber(string: loginView.telephoneTextField.text!) {
            print("手机号错误")
            return
        }
        
        if !String.isPassword(string: (loginView.passwordTextField?.text)!) {
            print("密码错误")
            return
        }
        
        if loginView.captchaTextField?.text?.characters.count != 4 {
            print("验证码错误")
            return
        }
        
        print("输入内容正确")
    }
}
