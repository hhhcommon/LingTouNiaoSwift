//
//  CrowdfundingCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let CrowdfundingCellHeight = adaptiveBaseIphone6(155)
private let Spacing =  adaptiveBaseIphone6(15)
private let RatioOfLeftAndRight = (1.0 / 2.0)

class CrowdfundingCell: UITableViewCell {

    var data: Any {
        get {
            return self.data
        }
        set {
            self.refresh(data: newValue)
        }
    }

    var hideTopLine: Bool {
        get {
            return self.hideTopLine
        }
        set {
            topLineView.isHidden = newValue
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(16)
        label.textColor = Color666666
        label.numberOfLines = 2
        //titleLabel.adjustsFontSizeToFitWidth = YES;
        return label
    }()
    
    lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(14)
        label.textColor = Color999999
        label.numberOfLines = 2
        //titleLabel.adjustsFontSizeToFitWidth = YES;
        return label
    }()
    
    lazy var startInvestLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.textColor = Color999999
        return label
    }()
    
    let crowdfundingProgress =  BarProgressView()

    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = LineColor
        return view
    }()
    
    lazy var lookForwardIV: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "home_look_forward"))
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addAllSubviews() {

        let backgroundView = UIView()
        contentView.addSubview(backgroundView)
        contentView.addSubview(topLineView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: Spacing, left: Spacing, bottom: Spacing, right: Spacing))
        }
        
        topLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: Spacing, left: Spacing, bottom: Spacing, right: Spacing))
            make.height.equalTo(1.0 / ScreenScale)
            make.top.equalToSuperview()
        }
        
        let leftView = UIView()
        backgroundView.addSubview(leftView)
        let rightView = UIView()
        backgroundView.addSubview(rightView)
        
        leftView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(backgroundView.width - Spacing).offset(-rightView.width)
            make.width.equalTo(rightView).multipliedBy(RatioOfLeftAndRight)
            make.left.top.equalToSuperview()
            make.right.equalTo(rightView.snp.left).offset(-Spacing)
        }

        rightView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.left.equalTo(leftView.snp.right).offset(Spacing)
            make.right.top.equalToSuperview()
        }
        
        
        leftView.addSubview(titleLabel)
        leftView.addSubview(incomeLabel)
        leftView.addSubview(startInvestLabel)
        leftView.addSubview(crowdfundingProgress)
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualToSuperview().multipliedBy(RatioOfLeftAndRight)
            make.left.top.width.equalToSuperview()

        }
        
        incomeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.center.width.equalToSuperview()
        }
        
        startInvestLabel.snp.makeConstraints { (make) in
            make.height.equalTo(12);
            make.left.width.equalToSuperview()
            make.bottom.equalTo(crowdfundingProgress.snp.top).offset(-5)
        }
        
        crowdfundingProgress.snp.makeConstraints { (make) in
            make.height.equalTo(1);
            make.left.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }

        rightView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(lookForwardIV)
        lookForwardIV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: Spacing, bottom: 0, right: Spacing))
        }
    }
    
    fileprivate func refresh(data: Any) {
        
        if let crowdfundingModel = data as? CrowdfundingModel {
            self.lookForwardIV.isHidden = true
            
            // 需要过滤html
            titleLabel.text = String.filterHTML(html: crowdfundingModel.productFirstTitle)
            if crowdfundingModel.productType == "B" {
                let annualIncomeText = String.filterHTML(html: crowdfundingModel.annualIncomeText)
                incomeLabel.text = "\(annualIncomeText)\(String.filterHTML(html: crowdfundingModel.productSubTitle))"
                incomeLabel.attributedText = incomeLabel.text?.configAttributesForString(attributes: [NSForegroundColorAttributeName : MainColor], string: annualIncomeText)
            } else {
                incomeLabel.text = "\(String.filterHTML(html: crowdfundingModel.productSubTitle))"
            }
            
            startInvestLabel.text = "\(crowdfundingModel.staInvestAmount)元起投"
            if crowdfundingModel.productTotalAmount > 0 {
                
                self.crowdfundingProgress.progress = CGFloat(crowdfundingModel.productSoldedAmount / crowdfundingModel.productTotalAmount)
            } else {
                self.crowdfundingProgress.progress = 0
            }
            contentImageView.sd_setImage(with: URL.init(string: crowdfundingModel.productTopPic), placeholderImage: UIImage.init(named:"placeholder_banner"))
        } else {
            lookForwardIV.isHidden = false
        }
    }
}
