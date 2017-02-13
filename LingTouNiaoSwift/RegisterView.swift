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
        // TODO:
    }
    internal func agreeProtocol(agree: Bool) {
        agreeProtocol = agree
        self.changeRegisterButtonStatus()
    }
    
    var agreeProtocol = true
    var captchaButton: UIButton?
    var registerSubmitBlock: ((UIButton) -> ())?
    var getCaptchaBlock: ((UIButton) -> ())? {
        willSet {
            captchaView.getCaptchaBlock = newValue
            print("\(newValue)")
        }
    }
    
    // 手机号
    lazy var telephoneTextField: CustomTextField = {
        var textField = CustomTextField.init(leftIconName: "icon_mobileno", placeholder: "推荐使用银行预留手机号")
        textField.drawBottomLine = true
        textField.limitedCount = 11
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()

    // 密码view
    var passwordTextField: CustomTextField?
    lazy var passwordView: PasswordView = {
        return PasswordView()
    }()
    
    // 短信验证码view
    var captchaTextField: CustomTextField?
    lazy var captchaView: CaptchaView = {
        return CaptchaView(loginType: .register)
    }()
    
    // 注册按钮
    lazy var registerButton: CustomButton = {
        var button = CustomButton.createBGButtonWithCorner(title: "注册", actionBlock: { (button) in
            self.registerSubmit()
        })
        button.isEnabled = false
        return button
    }()
    
    // 同意并阅读协议view
    lazy var agreeView: AgreeView = {
        var agreeView = AgreeView.init(agreeTitle: "我已阅读并同意", protocolName: "《在线服务协议》", fontSize: 12, delegate: self)
        return agreeView
    }()
    
    // 推荐人button
    lazy var refereeButton: UIButton = {
        var button = UIButton.createButton(title: "我有推荐人", color:LinkColor, font: normalFont(16), block: { (button) in
            self.clickReferee(button: button)
        })
        return button
    }()
    
    // 推荐邀请码
    lazy var refereeTextField: CustomTextField = {
        var textField = CustomTextField.init(leftIconName: "icon_recommend", placeholder: "请输入推荐人手机号")
        textField.drawBottomLine = true
        textField.drawTopLine = true
        textField.limitedCount = 11
        textField.isHidden = true
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()

    // TODO:
    // 温馨提示
//    LTNPromptView * promptView = [LTNPromptView promptWithIcon:@"icon_note_small" iconSpace:6 Text:locationString(@"register_prompt") font:kFont(12) textWidth:DimensionBaseIphone6(237)];
//    CGPoint promptCenter = CGPointMake(kScreenWidth * 0.5,  CGRectGetMaxY(registerButton.frame) + (kFieldHeight + promptView.bounds.size.height) * 0.5);
//    promptView.center = promptCenter;
//    [self.view addSubview:promptView];
//    self.promptView = promptView;
    
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
        self.addSubview(agreeView)
        self.addSubview(refereeButton)
        self.addSubview(refereeTextField)
        self.addSubview(registerButton)
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
        
        refereeButton.snp.makeConstraints { (make) in
            make.top.equalTo(agreeView.snp.bottom).offset(10)
            make.centerX.equalTo(agreeView)
        }
        
        refereeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(refereeButton.snp.bottom).offset(5)
            make.left.width.height.equalTo(captchaView)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(refereeButton.snp.bottom).offset(5)
            make.left.width.equalTo(refereeTextField)
            make.height.equalTo(GeneralSize)
        }
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldTextDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    // notification methods
    @objc fileprivate func textFieldTextDidChange(notification: Notification) {
        self.changeRegisterButtonStatus()
    }
    
    fileprivate func changeRegisterButtonStatus() {
        if agreeProtocol && (telephoneTextField.text?.characters.count)! > 0 && (passwordTextField?.text?.characters.count)! > 0 && (captchaTextField?.text?.characters.count)! > 0 {
            if refereeButton.isSelected {
                if (refereeTextField.text?.characters.count)! > 0 {
                    registerButton.isEnabled = true
                } else {
                    registerButton.isEnabled = false
                }
            } else {
                registerButton.isEnabled = true
            }
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
    
    func clickReferee(button: UIButton) {
        button.isSelected = !button.isSelected
        refereeTextField.isHidden = !button.isSelected
        if button.isSelected {
            refereeTextField.text = ""
        }
        self.changeRegisterButtonStatus()
        self.updateConstraints()
    }
    
    override func needsUpdateConstraints() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        if refereeButton.isSelected {
            registerButton.snp.remakeConstraints { (make) in
                make.top.equalTo(refereeTextField.snp.bottom).offset(16)
                make.left.width.equalTo(refereeTextField)
                make.height.equalTo(GeneralSize)
            }
        } else {
            registerButton.snp.remakeConstraints { (make) in
                make.top.equalTo(refereeButton.snp.bottom).offset(5)
                make.left.width.equalTo(refereeTextField)
                make.height.equalTo(GeneralSize)
            }
        }
        super.updateConstraints()
    }
}
