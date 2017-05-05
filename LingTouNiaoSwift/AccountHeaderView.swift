//
//  AccountHeaderView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 2017/5/4.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

@objc protocol AccountHeaderViewDelegate {
//    @objc optional func clickAcitonBar(actionBar: ActionBar, itemIndex: NSInteger)
//    @objc optional func clickCheckReport()
//    @objc optional func clickMessageCenter(button: UIButton)
}

class AccountHeaderView: UIView {

    // delegate
    var delegate: AccountHeaderViewDelegate?
    
    // 背景图
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_accountBg")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 姓名label
    let userNameLabel = UILabel.createLabel(color: WhiteColor, font: normalFont(14))
    
    // 待收收益
    let expectedIncomeLabel = UILabel.createLabel(color: WhiteColor, font: normalFont(32))

    lazy var expectedIncomeView: UIView = {
        
        let view = UIView()
        
        view.addSubview(self.expectedIncomeLabel)
        
        let expectedIncomeTitleLabel = UILabel.createLabel(text: "待收收益(元)>", color: WhiteColor, font: normalFont(11))
        view.addSubview(expectedIncomeTitleLabel)
    
        // todo:
        // 少小眼睛
        return view
    }()
    
    // 提现按钮
    lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("提现", for: UIControlState.normal)
        button.setImage(UIImage.init(named: "icon_tixian"), for: UIControlState.normal)
        button.setTitleColor(WhiteColor, for: UIControlState.normal)
//        button.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: -10, bottom: 5, right: (button.titleLabel?.width)!)
        return button
    }()
    
    // 充值按钮
    lazy var rechargeButton: UIButton = {
        let button = UIButton()
        button.setTitle("充值", for: UIControlState.normal)
        button.setImage(UIImage.init(named: "icon_chongzhi"), for: UIControlState.normal)
        button.setTitleColor(WhiteColor, for: UIControlState.normal)
        return button
    }()
    
    // 总资产
    let totalAssetLabel = UILabel.createLabel(text: "0.00", color: WhiteColor, font: normalFont(13))
    
    lazy var totalAssetView: UIView = {
        let view = UIView()
        view.addSubview(self.totalAssetLabel)
        
        let totalAssetTitleLabel = UILabel.createLabel(text: "总资产(元)", color: WhiteColor, font: normalFont(11))
        view.addSubview(totalAssetTitleLabel)
        
        return view
    }()
    
    // 可用余额
    let usableBalanceLabel = UILabel.createLabel(text: "0.00", color: WhiteColor, font: normalFont(13))
    
    lazy var usableBalanceView: UIView = {
        let view = UIView()
        view.addSubview(self.usableBalanceLabel)
        
        let usableBalanceTitleLabel = UILabel.createLabel(text: "可用余额(元)", color: WhiteColor, font: normalFont(11))
        view.addSubview(usableBalanceTitleLabel)
        
        return view
    }()
    
    // 可用鸟币
    let usableBirdCoinLabel = UILabel.createLabel(text: "0.00", color: WhiteColor, font: normalFont(13))
    
    lazy var usableBirdCoinView: UIView = {
        let view = UIView()
        view.addSubview(self.usableBirdCoinLabel)
        
        let usableBirdCoinTitleLabel = UILabel.createLabel(text: "可用鸟币", color: WhiteColor, font: normalFont(11))
        view.addSubview(usableBirdCoinTitleLabel)
        
        return view
    }()
    
    class func getAccountHeaderViewWithDelegate(delegate: AccountHeaderViewDelegate) -> AccountHeaderView {
        
        let accountHeaderView = AccountHeaderView.init(frame: CGRect.zero, delegate: delegate)
        accountHeaderView.delegate = delegate
        
        return accountHeaderView
    }
    
    // MARK: - init方法
    init(frame: CGRect, delegate: AccountHeaderViewDelegate) {
        super.init(frame: frame)
        self.addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAllSubviews() {
        
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.userNameLabel)
        self.addSubview(self.expectedIncomeView)
        self.addSubview(self.withdrawButton)
        self.addSubview(self.rechargeButton)
        self.addSubview(self.totalAssetView)
        self.addSubview(self.usableBalanceView)
        self.addSubview(self.usableBirdCoinView)
        
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = WhiteColor
        self.addSubview(horizontalLine)
        
        let verticalLine1 = UIView()
        verticalLine1.backgroundColor = WhiteColor
        self.addSubview(verticalLine1)
        
        let verticalLine2 = UIView()
        verticalLine2.backgroundColor = WhiteColor
        self.addSubview(verticalLine2)
        
        // 自动布局
        
    }
    
}
