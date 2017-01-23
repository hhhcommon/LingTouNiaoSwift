//
//  CaptchaView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/9.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

enum LoginType {
    case login
    case register
}

class CaptchaView: UIView {

    let captchaButton = UIButton()
    var getCaptchaBlock: ((UIButton) -> ())?
    var loginType = LoginType.login
    
    lazy var captchaTextField: CustomTextField = {
        var textField = CustomTextField.init(leftIconName: "icon_captcha", placeholder: "请输入验证码")
        textField.drawBottomLine = true
        textField.limitedCount = 4
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    
    init(loginType: LoginType) {
        super.init(frame: CGRect.zero)
        self.loginType = loginType
        addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllSubviews() {
        
        self.addSubview(captchaTextField)
        
        if loginType == .login {
            captchaButton.setImage(UIImage.init(named: "placeholder_refresh"), for: UIControlState.normal)
        } else if loginType == .register {
            captchaButton.titleLabel?.font = normalFont(15)
            captchaButton.setTitle("获取验证码", for: UIControlState.normal)
            captchaButton.setTitleColor(LinkColor, for: UIControlState.normal)
            captchaButton.setTitleColor(DisabledColor, for: UIControlState.disabled)
        }
        
        captchaButton.addTarget(self, action: #selector(getCaptcha(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(captchaButton)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = LineColor
        self.addSubview(bottomLine)
        
        let verticalLine = UIView()
        verticalLine.backgroundColor = LineColor
        self.addSubview(verticalLine)
        
        captchaTextField.snp.makeConstraints { (make) in
            make.left.top.height.equalToSuperview()
            make.right.equalTo(captchaButton.snp.left)
        }
        
        captchaButton.snp.makeConstraints { (make) in
            make.right.top.height.equalToSuperview()
            make.width.equalTo(self.loginType == .login ? 60 : 98)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.width.equalTo(captchaButton)
            make.height.equalTo(captchaTextField.lineWidth)
        }
        
        verticalLine.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.height.equalToSuperview().offset(-2 * 5)
            make.right.equalTo(captchaButton.snp.left)
            make.width.equalTo(LineThick)
        }
    }
    
    func getCaptcha(button: UIButton) {
        if self.getCaptchaBlock != nil {
            self.getCaptchaBlock!(button)
        }
    }

}
