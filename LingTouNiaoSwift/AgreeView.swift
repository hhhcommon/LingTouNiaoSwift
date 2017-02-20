//
//  AgreeView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/9.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

@objc protocol AgreeViewDelegate {
    @objc optional func showProtocol()
    @objc optional func agreeProtocol(agree: Bool)
}

class AgreeView: UIView {

    private var delegate : AgreeViewDelegate?
    private var fontSize: CGFloat = 12
    private var agreeTitle: String?
    private var protocolName: String?
    
    convenience init(agreeTitle: String?, protocolName: String?, fontSize: CGFloat, delegate: AgreeViewDelegate?) {
        self.init()
        self.agreeTitle = agreeTitle
        self.protocolName = protocolName
        self.fontSize = fontSize
        self.delegate = delegate
        addAllSubviews()
    }
    
    fileprivate func addAllSubviews() {
        
        let backView = UIView()
        self.addSubview(backView)
        
        // 阅读并同意协议button
        let agreeButton = UIButton.createButton(nomalIconName: "unchecked_single", selectedIconName: "checked_single") { (button) in
            button.isSelected = !button.isSelected
            self.delegate?.agreeProtocol(agree: button.isSelected)
        }
        agreeButton.isSelected = true
        backView.addSubview(agreeButton)
        
        // 阅读并同意协议label
        if (self.agreeTitle?.isEmpty)! {
            return
        }
        let agreeTitleLabel = UILabel.init()
        agreeTitleLabel.font = normalFont(fontSize)
        agreeTitleLabel.textColor = Color999999
        agreeTitleLabel.text = agreeTitle
        agreeTitleLabel.sizeToFit()
        backView.addSubview(agreeTitleLabel)
        
        // 协议名字按钮
        if (self.protocolName?.isEmpty)! {
            return
        }
        let protocolButton = UIButton.createButton(title: protocolName!, color: LinkColor, font: normalFont(fontSize)) { (button) in
            self.delegate?.showProtocol()
        }
        protocolButton.left = agreeTitleLabel.right
        backView.addSubview(protocolButton)
        
        let height = max(agreeButton.height, agreeTitleLabel.height)
        let agreeButtonSize: CGFloat = 24
        agreeButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: agreeButtonSize, height: agreeButtonSize))
            make.centerY.left.equalTo(backView)
        }
        
        agreeTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(agreeButton.snp.right).offset(5)
            make.centerY.equalTo(backView)
        }
        
        protocolButton.snp.makeConstraints { (make) in
            make.left.equalTo(agreeTitleLabel.snp.right)
            make.centerY.equalTo(backView)
        }
        
        backView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(height)
            make.width.equalTo(agreeButtonSize + 5 + agreeTitleLabel.width + protocolButton.width)
        }
    }
}
