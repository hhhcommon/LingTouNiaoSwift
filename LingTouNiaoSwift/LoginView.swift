//
//  LoginView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/4.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    var captchaButton: UIButton?
    var loginSubmitBlock: ((UIButton) -> ())?
    var getCaptchaBlock: ((UIButton) -> ())?

    lazy var telephoneTextField: CustomTextField = {
        var textField = CustomTextField.init(leftIconName: "icon_username", placeholder: "请输入手机号")
        textField.drawBottomLine = true
        textField.limitedCount = 11
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    var passwordTextField: CustomTextField?
    lazy var passwordView: PasswordView = {
        return PasswordView()
    }()
    var captchaTextField: CustomTextField?
    lazy var captchaView: CaptchaView = {
        return CaptchaView(loginType: .login)
    }()
    lazy var loginButton: CustomButton = {
        var button = CustomButton.createBGButtonWithCorner(title: "登录", actionBlock: { (button) in
            self.loginSubmit()
        })
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubviews()
        registerNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldTextDidChange(textField:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    fileprivate func addAllSubviews() {
        
        self.addSubview(telephoneTextField)
        self.addSubview(passwordView)
        self.addSubview(captchaView)
        self.addSubview(loginButton)
        passwordTextField = passwordView.passwordTextField
        captchaTextField = captchaView.captchaTextField
        captchaButton = captchaView.captchaButton
        captchaView.getCaptchaBlock = { (button) in
            if self.getCaptchaBlock != nil {
                self.getCaptchaBlock!(button)
            }
        }
        
        telephoneTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptiveBaseIphone6(30))
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-20 * 2)
            make.height.equalTo(49)
        }
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(telephoneTextField.snp.bottom)
            make.left.width.height.equalTo(telephoneTextField)
        }
        captchaView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom)
            make.left.width.height.equalTo(passwordView)
        }
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(captchaView.snp.bottom).offset(30)
            make.left.width.equalTo(captchaView)
            make.height.equalTo(GeneralSize)
        }
    }
    
    // notification methods
    func textFieldTextDidChange(textField: UITextField) {
        if (telephoneTextField.text?.characters.count)! > 0 && (passwordTextField?.text?.characters.count)! > 0 && (captchaTextField?.text?.characters.count)! > 0{
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    fileprivate func loginSubmit() {
        if loginSubmitBlock != nil {
            loginSubmitBlock!(loginButton)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
