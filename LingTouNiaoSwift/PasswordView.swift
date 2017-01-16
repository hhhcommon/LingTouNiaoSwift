//
//  PasswordView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/9.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import SnapKit

class PasswordView: UIView {

    lazy var passwordTextField: CustomTextField = {
        var textField = CustomTextField.init(leftIconName: "icon_password", placeholder: "请输入密码")
        textField.drawBottomLine = true
        textField.limitedCount = 18
        textField.isSecureTextEntry = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllSubviews() {
        
        self.addSubview(passwordTextField)
        
        let hidenButton = UIButton()
        hidenButton.setImage(UIImage.init(named: "icon_hide"), for: UIControlState.normal)
        hidenButton.setImage(UIImage.init(named: "icon_show"), for: UIControlState.selected)
        hidenButton.addTarget(self, action: #selector(showPassword(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(hidenButton)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = LineColor
        self.addSubview(bottomLine)
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.top.height.equalToSuperview()
            make.right.equalTo(hidenButton.snp.left)
        }
        
        hidenButton.snp.makeConstraints { (make) in
            make.right.top.height.equalToSuperview()
            make.width.equalTo(30)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.width.equalTo(hidenButton)
            make.height.equalTo(passwordTextField.lineWidth)
        }
    }
    
    func showPassword(button: UIButton) {
        passwordTextField.isSecureTextEntry = button.isSelected
        button.isSelected = !button.isSelected
    }
}
