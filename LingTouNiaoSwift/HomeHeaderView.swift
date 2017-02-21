//
//  HomeHeaderView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let PlatformRegisterNum = "platformRegisterNum"
let PlatformAllAmount = "platformAllAmount"
let SumRevenue = "sumRevenue"
let UnreadMessageCount = "unreadMessageCount"

@objc protocol HomeHeaderViewDelegate {
    @objc optional func clickAcitonBar(actionBar: ActionBar, itemIndex: NSInteger)
    @objc optional func clickCheckReport()
    @objc optional func clickMessageCenter(button: UIButton)
}

// 总高度
let HeaderTotalHeight = adaptiveBaseIphone6(350)

private let Margin = adaptiveBaseIphone6(12.5)
// dock高度
private let DockHeight = adaptiveBaseIphone6(90)
// 平台信息高度
private let PlatformHeight = adaptiveBaseIphone6(65)
// 底部阴影高度
private let BottomShadowHeight = adaptiveBaseIphone6(4)
// 底部视图总高
private var BottomTotalHeight: CGFloat {
    get {
        return DockHeight + PlatformHeight + BottomShadowHeight
    }
}
// 底部试图距离最底端的距离
private let SpacingWithBottomViewAndBottomLine = adaptiveBaseIphone6(8)
// 信息数量圆直径
private let MessageCountLabelDiam: CGFloat = 16

class HomeHeaderView: UIView, AcitonBarDelegate {
    
    // delegate
    var delegate: HomeHeaderViewDelegate?
    
    // MARK: - 平台累计投资总额label
    lazy var platformTotalLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(18)
        label.textColor = Color666666
        return label
    }()
    
    // MARK: - 平台用户注册总数label
    lazy var registerTotalLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(18)
        label.textColor = Color666666
        return label
    }()
    
    // MARK: - 用户赚取收益总额label
    lazy var incomeTotalLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(18)
        label.textColor = Color666666
        return label
    }()

    // MARK: - 消息中心上显示数量的label
    lazy var messageAmountLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(10)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.red
        label.layer.cornerRadius = MessageCountLabelDiam * 0.5
        label.layer.masksToBounds = true
//        label.isHidden = true
        return label
    }()
    
    lazy var actionBar: ActionBar = {
        let actionBar = ActionBar(frame: CGRect(x: 0, y: 0, width: self.width - 2 * Margin, height: DockHeight))
        actionBar.backgroundColor = UIColor.white
        actionBar.delegate = self
        actionBar.addActionItem(icon: "pinpai", selectedIcon: nil, title: "品牌介绍")
        actionBar.addActionItem(icon: "huodong", selectedIcon: nil, title: "热门活动")
        actionBar.addActionItem(icon: "licaijinjuan", selectedIcon: nil, title: "理财金券")
        actionBar.addActionItem(icon: "anquanbaozhang", selectedIcon: nil, title: "安全保障")
        return actionBar
    }()
    
    lazy var platformView: UIView = {
        let platformView = UIView()
        
        // 平台累计投资
        let platformTotalView = UIView()
        platformView.addSubview(platformTotalView)
        
        // 平台用户突破
        let registerTotalView = UIView()
        platformView.addSubview(registerTotalView)
        
        // 用户赚取收益
        let incomeTotalView = UIView()
        platformView.addSubview(incomeTotalView)
        
        platformTotalView.snp.makeConstraints({ (make) in
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.width.equalTo(registerTotalView)
            make.left.top.height.equalToSuperview()
            make.right.equalTo(registerTotalView.snp.left)
        })
        
        registerTotalView.snp.makeConstraints({ (make) in
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.width.equalTo(incomeTotalView)
            make.top.height.equalToSuperview()
            make.left.equalTo(platformTotalView.snp.right)
            make.right.equalTo(incomeTotalView.snp.left)
        })
        
        incomeTotalView.snp.makeConstraints({ (make) in
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.width.equalTo(platformTotalView)
            make.top.height.right.equalToSuperview()
            make.left.equalTo(platformTotalView.snp.right)
        })
        
        
        platformTotalView.addSubview(self.platformTotalLabel)
        let platformTotalTitleLabel = self.createLabelWithTitle("平台累计投资")
        platformTotalView.addSubview(platformTotalTitleLabel)
        self.addConstraintsForDataView(self.platformTotalLabel)
        self.addConstraintsForTitleView(platformTotalTitleLabel)

        registerTotalView.addSubview(self.registerTotalLabel)
        let registerTotalTitleLabel = self.createLabelWithTitle("平台用户突破")
        registerTotalView.addSubview(registerTotalTitleLabel)
        self.addConstraintsForDataView(self.registerTotalLabel)
        self.addConstraintsForTitleView(registerTotalTitleLabel)
        
        incomeTotalView.addSubview(self.incomeTotalLabel)
        let incomeTotalTitleLabel = self.createLabelWithTitle("用户赚取收益")
        incomeTotalView.addSubview(incomeTotalTitleLabel)
        self.addConstraintsForDataView(self.incomeTotalLabel)
        self.addConstraintsForTitleView(incomeTotalTitleLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickCheckReport))
        platformView.addGestureRecognizer(tap)
        
        return platformView
    }()
    
    // MARK: - background view
    lazy var backgroundView: UIView = {
        let backgroundView = UIView(frame: self.bounds)
        
        // 背景图
        let bacrgroundImageView = UIImageView.init(frame: backgroundView.bounds)
        bacrgroundImageView.image = UIImage.init(named: "header_homepage")
        backgroundView.addSubview(bacrgroundImageView)
        
        // 消息中心按钮
        let messageImage = UIImage.init(named: "tixing")
        messageImage!.withRenderingMode(.alwaysOriginal)
        
        let messageButton = UIButton()
        messageButton.setImage(messageImage, for: UIControlState.normal)
        messageButton.addTarget(self, action: #selector(self.messageClick(messageButton:)), for: UIControlEvents.touchUpInside)
        messageButton.addSubview(self.messageAmountLabel)
        backgroundView.addSubview(messageButton)
       
        messageButton.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-Margin)
            make.size.equalTo(CGSize(width: (messageImage?.size.width)!, height: (messageImage?.size.height)!))
            make.top.equalToSuperview().offset(30)
        })

        self.messageAmountLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(messageButton.snp.top).offset(5)
            make.size.equalTo(CGSize(width: MessageCountLabelDiam, height: MessageCountLabelDiam))
            make.centerX.equalTo(messageImage!.size.width)
        })
        return backgroundView
    }()
    
    // MARK: - bottom view
    lazy var bottomView: UIView = {
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        bottomView.addSubview(self.actionBar)
        bottomView.addSubview(self.platformView)
        
        let lineView = UIView()
        lineView.backgroundColor = LineColor
        bottomView.addSubview(lineView)
            
        self.actionBar.snp.makeConstraints({ (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(DockHeight)
            make.bottom.equalTo(self.platformView.snp.top)
        })
        
        self.platformView.snp.makeConstraints({ (make) in
            make.left.bottom.width.equalToSuperview()
            make.height.equalTo(PlatformHeight)
            make.top.equalTo(self.actionBar.snp.bottom)
        })
        
        lineView.snp.makeConstraints({ (make) in
            make.height.equalTo(1 / ScreenScale)
            make.width.equalToSuperview().offset(-2.0 * Margin);
            make.top.equalTo(self.actionBar.snp.bottom)
            make.centerX.equalToSuperview()
        })
            
        //加阴影
        bottomView.layer.shadowColor = UIColor.black.cgColor    //shadowColor阴影颜色
        bottomView.layer.shadowOffset = CGSize(width: BottomShadowHeight, height: BottomShadowHeight)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        bottomView.layer.shadowOpacity = 0.1    //阴影透明度，默认0
//        bottomView.layer.shadowRadius = 4;//阴影半径，默认3
        return bottomView
    }()
    
    class func getHomeHeaderViewWithDelegate(delegate: HomeHeaderViewDelegate) -> HomeHeaderView {
        
        let homeHeaderView = HomeHeaderView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: HeaderTotalHeight), delegate: delegate)
        return homeHeaderView
    }
    
    init(frame: CGRect, delegate: HomeHeaderViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        self.addSubview(self.backgroundView)
        self.addSubview(self.bottomView)
        
        self.bottomView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margin);
            make.right.equalToSuperview().offset(-Margin);
            make.height.equalTo(BottomTotalHeight);
            make.width.equalToSuperview().offset(-2.0 * Margin);
            make.bottom.equalToSuperview().offset(-SpacingWithBottomViewAndBottomLine);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - actionBar delegate
    func clickAcitonBar(actionBar: ActionBar, index: NSInteger) {
        self.delegate?.clickAcitonBar!(actionBar: actionBar, itemIndex: index)
    }
    
    // MARK: - event methods
    func messageClick(messageButton: UIButton) {
        ControllersManager.shared.actionWhenLogin { () in
            self.delegate?.clickMessageCenter!(button: messageButton)
        }
    }
    
    func clickCheckReport() {
        self.delegate?.clickCheckReport!()
    }
    
    // MARK: - private methods
    fileprivate func addConstraintsForTitleView(_ view: UIView) {
        let superView = view.superview
        if superView != nil {
            view.snp.makeConstraints({ (make) in
                make.top.equalTo(superView!.snp.centerY).offset(5)
                make.centerX.equalTo(superView!.snp.centerX)
            })
        }
    }
    
    fileprivate func addConstraintsForDataView(_ view: UIView) {
        let superView = view.superview
        if superView != nil {
            view.snp.makeConstraints({ (make) in
                make.bottom.equalTo(superView!.snp.centerY).offset(2.5)
                make.centerX.equalTo(superView!.snp.centerX)
            })
        }
    }
    
    fileprivate func createLabelWithTitle(_ title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = normalFont(11)
        titleLabel.textColor = Color666666
        titleLabel.text = title
        titleLabel.sizeToFit()
        return titleLabel;
    }
    
    func refresh() {
        let defaults = UserDefaults.standard
        platformTotalLabel.text = defaults.string(forKey: PlatformAllAmount)
        platformTotalLabel.sizeToFit()
        self.addAttributesForLabel(platformTotalLabel)
        
        registerTotalLabel.text = defaults.string(forKey: PlatformRegisterNum)
        registerTotalLabel.sizeToFit()
        self.addAttributesForLabel(registerTotalLabel)
        incomeTotalLabel.text = defaults.string(forKey: SumRevenue)
        incomeTotalLabel.sizeToFit()
        self.addAttributesForLabel(incomeTotalLabel)
        self.updateMessageCount()
    }
    
    fileprivate func addAttributesForLabel(_ label: UILabel) {
        if (label.text?.characters.count)! > 2 {
//            [label addAttributesWithFontSize:15 forString:[label.text substringWithRange:NSMakeRange(label.text.length - 2, 2)]];
        }
    }
    
    fileprivate func updateMessageCount() {
        //    NSInteger unreadMessageCount = [CurrentUser mine].accountInfo.unreadMessageCount;
        let unreadMessageCount = UserDefaults.standard.integer(forKey: UnreadMessageCount)
        if unreadMessageCount > 0 {
            messageAmountLabel.isHidden = false
            messageAmountLabel.text = "\(unreadMessageCount)"
        } else {
            messageAmountLabel.isHidden = true
        }
    }
}
