//
//  RegisterController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/3.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class RegisterController: BaseViewController {

    let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        view.addSubview(registerView)
        registerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        registerView.registerSubmitBlock = { (button) in
            self.registerSubmit(button)
        }
        registerView.getCaptchaBlock = { (button) in
            self.getCaptchaSubmit(button)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        registerView.stopTimer()
    }
    
    fileprivate func getCaptchaSubmit(_ button: UIButton) {
        print("获取验证码")
        if !String.isPhoneNumber(string: registerView.telephoneTextField.text!) {
            print("手机号错误")
            return
        }
        
        let params = ["mobileNo" : registerView.telephoneTextField.text!, "sendType" : NSNumber.init(value: 1)] as [String : Any]
        
        button.isEnabled = false
        RegisterModel.getMessageCode(params: params, block: { (response, error) in
            button.isEnabled = true
            if error == nil {
                self.registerView.startTimer()
            }
        })
    }
    
    fileprivate func registerSubmit(_ button: UIButton) {
        if !String.isPhoneNumber(string: registerView.telephoneTextField.text!) {
            _ = NSObject.showMessage(message: "手机号错误")
            return
        }
        
        if !String.isPassword(string: (registerView.passwordTextField?.text)!) {
            _ = NSObject.showMessage(message: "密码错误")
            return
        }
        
        if registerView.captchaTextField?.text?.characters.count != 4 {
            _ = NSObject.showMessage(message: "验证码错误")
            return
        }
        
        if registerView.registerButton.isSelected && !String.isPhoneNumber(string: registerView.refereeTextField.text!) {
            _ = NSObject.showMessage(message: "推荐人手机号错误")
        }
        
        let dictionary: Dictionary<String, Any> = [
            "mobileNo" : registerView.telephoneTextField.text!,
            "password" : (registerView.passwordTextField?.text)!,
            "mobileCode" : (registerView.captchaTextField?.text)!,
            "partnerMobile" : registerView.refereeTextField.text ?? "",
            "readAndAgree" : NSNumber.init(value: 1)
            ]
        RegisterModel.userRegister(params: dictionary) { (response, error) in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.finishBlock()
            }
        }
    }
}
