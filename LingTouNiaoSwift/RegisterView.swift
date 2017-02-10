//
//  RegisterView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/22.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class RegisterView: UIView, AgreeViewDelegate {
    
    internal func showProtocol() {
        
    }
    internal func agreeProtocol(agree: Bool) {
        
    }
    
    var captchaButton: UIButton?
    var registerSubmitBlock: ((UIButton) -> ())?
    var getCaptchaBlock: ((UIButton) -> ())? {
        willSet {
            captchaView.getCaptchaBlock = newValue
            print("\(newValue)")
        }
    }
    
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
    
    lazy var agreeView: AgreeView = {
        var agreeView = AgreeView.init(agreeTitle: "我已阅读并同意", protocolName: "《在线服务协议》", fontSize: 12, delegate: self)
        return agreeView
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
        self.addSubview(agreeView)
        self.passwordTextField = passwordView.passwordTextField
        self.captchaTextField = captchaView.captchaTextField
        captchaButton = captchaView.captchaButton
        
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
        agreeView.snp.makeConstraints { (make) in
            make.top.equalTo(captchaView.snp.bottom).offset(16)
            make.centerX.equalTo(captchaView)
            make.width.equalTo(captchaView)
            make.height.equalTo(24)
        }
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(agreeView.snp.bottom).offset(30)
            make.left.width.equalTo(captchaView)
            make.height.equalTo(GeneralSize)
        }
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldTextDidChange(textField:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    // notification methods
    @objc fileprivate func textFieldTextDidChange(textField: UITextField) {
        if (telephoneTextField.text?.characters.count)! > 0 && (passwordTextField?.text?.characters.count)! > 0 && (captchaTextField?.text?.characters.count)! > 0 {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
    
    fileprivate func registerSubmit() {
        if registerSubmitBlock != nil {
            registerSubmitBlock!(registerButton)
        }
    }
    
    func startTimer() {
        captchaView.startTimer()
    }
    
    func stopTimer() {
        captchaView.stopTimer()
    }
}
