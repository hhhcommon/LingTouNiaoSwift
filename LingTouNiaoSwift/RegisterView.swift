//
//  RegisterView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/22.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    lazy var telephoneTextField: CustomTextField = {
        var textField = CustomTextField.init(leftIconName: "icon_mobileno", placeholder: "推荐使用银行预留手机号")
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
        return CaptchaView(loginType: .register)
    }()
    
    lazy var registerButton: CustomButton = {
        var button = CustomButton.createBGButtonWithCorner(title: "注册", actionBlock: { (button) in
            self.registerSubmit()
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
    
    func addAllSubviews() {
        self.addSubview(telephoneTextField)
        self.addSubview(passwordView)
        self.addSubview(captchaView)
        self.addSubview(registerButton)
        self.passwordTextField = passwordView.passwordTextField
        self.captchaTextField = captchaView.captchaTextField
        
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
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(captchaView.snp.bottom).offset(30)
            make.left.width.equalTo(captchaView)
            make.height.equalTo(GeneralSize)
        }
    }
    
    func registerNotifications() {
        
    }
    
    func registerSubmit() {
        print("注册")
    }
}
