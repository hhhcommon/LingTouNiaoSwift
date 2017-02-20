//
//  ProductListCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let BaseProductListCellHeight: CGFloat = 150

class ProductListCell: UITableViewCell {

    private let leftMargin: CGFloat = 24
    private let topMargin: CGFloat = 15
    var product: ProductModel? {
        get {
            return self.product
        }
        set {
            if newValue != nil {
                self.setBaseData(newValue!)
            }
        }
    }
    
    let backView = UIView()
    let productNameLabel: UILabel = {
        let productNameLabel = UILabel()
        productNameLabel.font = normalFont(16)
        return productNameLabel
    }()
    
    let cornerMarkImageView = UIImageView()
    let watermarkImageView = UIImageView()
    
    // 年化收益率
    let annualIncomeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.text = "年化收益率"
        return label
    }()
    
    let annualIncomeDataLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(30)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // 投资期限
    let investDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.text = "投资期限"
        return label
    }()
    
    let investDateDataLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(24)
        return label
    }()
    
    // 剩余金额
    let remainingAmountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.text = "剩余金额"
        return label
    }()
    
    let remainingAmountDataLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(16)
        return label
    }()
    
    // 进度条
    let progressView: BarProgressView = {
        let progressView = BarProgressView()
        progressView.groundColor = ColorECECEC
        return progressView
    }()
    
    // 起投金额
    let staInvestAmountLable: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // 产品类型tag
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        return label
    }()
    
    // 分隔线
    let separateLine: UIView = {
        let separateLine = UIView()
        separateLine.backgroundColor = LineColor
        return separateLine
    }()
    
    // 购买按钮
    let purchaseButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = normalFont(14)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.layer.cornerRadius = 2.5
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = backgroundColor
        backView.frame = CGRect(x: 0, y: 0, width: Int(ScreenWidth), height: Int(BaseProductListCellHeight - 10))
        contentView.addSubview(backView)
        backView.backgroundColor = UIColor.white
        self.addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBaseData(_ product: ProductModel) {
        // 产品名称
        productNameLabel.text = product.productName
        productNameLabel.textColor = product.isRepaymenting() ? DisabledColor : Color666666
        
        // 角标
        var image: UIImage?
        if product.productType == "TYB" {
            image = UIImage(named: "icon_label_ty")
        } else if product.productType == "XSB" {
            image = UIImage(named: "icon_label_sxt")
        }
        cornerMarkImageView.image = image
        
        // 产品状态图标
        image = product.isRepaymenting() ? UIImage(named: "watermark_over") : nil
        watermarkImageView.image = image
        
        let dataTitleColor = product.isRepaymenting() ? DisabledColor : Color666666
        // 年化收益率
        annualIncomeTitleLabel.textColor = dataTitleColor
        annualIncomeDataLabel.text = product.annualIncomeText
        annualIncomeDataLabel.textColor = product.isRepaymenting() ? DisabledColor : MainColor
        
        // 投资期限
        investDateTitleLabel.textColor = dataTitleColor
        var deadlineUnit: String
        if product.deadlineUnit == "Y" {
            deadlineUnit = "年"
        } else if product.deadlineUnit == "M" {
            deadlineUnit = "个月"
        } else {
            deadlineUnit = "天"
        }
        investDateDataLabel.textColor = dataTitleColor
        investDateDataLabel.text = product.productType == "SXT" ? "随存随取" : "\(product.productDeadline)\(deadlineUnit)"
        
        // 剩余金额
        remainingAmountTitleLabel.textColor = dataTitleColor
        if !product.isTYB() {
            remainingAmountTitleLabel.isHidden = false
            remainingAmountDataLabel.isHidden = false
            let remainAmount: String
            if product.productRemainAmount >= 10000 {
                remainAmount = String(format: "%.2f万", product.productRemainAmount / 10000.0)
            } else {
                remainAmount = "\(product.productRemainAmount)元"
            }
            remainingAmountDataLabel.textColor = dataTitleColor
            remainingAmountDataLabel.text = remainAmount
        } else {
            remainingAmountTitleLabel.isHidden = true
            remainingAmountDataLabel.isHidden = true
        }
        
        // 投资进度
        let raseAmount = product.productTotalAmount - product.productRemainAmount
        let progress = raseAmount / product.productTotalAmount
        progressView.progressColor = product.isRepaymenting() ? DisabledColor : MainColor
        progressView.progress = CGFloat(progress)
        
        // 起投金额
        staInvestAmountLable.textColor = dataTitleColor
        staInvestAmountLable.text = "\(product.staInvestAmount)元起投"
        
        // 产品类型
        let tagString = product.isXSB() ? "仅可购买一个新手项目" : product.productTag
        if tagString.isEmpty {
            separateLine.isHidden = true
            tagLabel.isHidden = true
        } else {
            separateLine.isHidden = false
            tagLabel.isHidden = false
            tagLabel.textColor = dataTitleColor
            tagLabel.text = product.productTag
        }
        
        // 购买按钮
        purchaseButton.backgroundColor = product.isRepaymenting() ? DisabledColor : MainColor
        var purchaseTitle: String
        var purchaseEnabled: Bool
        if product.isTYB() {
            purchaseTitle = "立即体验"
            purchaseEnabled = true
        } else if product.isRepaymenting() {
            purchaseTitle = "募集结束"
            purchaseEnabled = false
        } else {
            purchaseTitle = "立即购买"
            purchaseEnabled = true
        }
        
        if product.isArrange == "1" && !product.isRepaymenting() {
            purchaseTitle = "立即预约"
            purchaseEnabled = true
        }
        
        purchaseButton.setTitle(purchaseTitle, for: UIControlState.normal)
        purchaseButton.isEnabled = purchaseEnabled
    }
    
    func addAllSubviews() {
        
        // 0.头部线条
        let headerLineView = UIView()
        headerLineView.backgroundColor = LineColor
        backView.addSubview(headerLineView)
        headerLineView.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(LineThick)
        }
        
        // 1.产品名称
        backView.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(topMargin)
            make.left.equalToSuperview().offset(leftMargin)
            make.width.equalToSuperview().offset(-2 * leftMargin)
            make.height.equalTo(12)
        }
        
        // 2.角标
        backView.addSubview(cornerMarkImageView)
        cornerMarkImageView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
        }
        
        // 3.产品状态图标
        backView.addSubview(watermarkImageView)
        watermarkImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview()
        }
        
        let annualWidth = (ScreenWidth - 2 * leftMargin) * 2 / 5.0
        let otherWidth = (ScreenWidth - 2 * leftMargin - annualWidth) * 0.5
        
        // 4.年化收益率
        backView.addSubview(annualIncomeDataLabel)
        backView.addSubview(annualIncomeTitleLabel)
        
        // 5.投资期限
        backView.addSubview(investDateDataLabel)
        backView.addSubview(investDateTitleLabel)
        
        // 6.剩余金额
        backView.addSubview(remainingAmountDataLabel)
        backView.addSubview(remainingAmountTitleLabel)
        
        annualIncomeDataLabel.snp.makeConstraints { (make) in
            make.left.equalTo(productNameLabel)
            make.top.equalTo(productNameLabel.snp.bottom).offset(15)
            make.width.equalTo(annualWidth)
            make.height.equalTo(30)
        }
        
        annualIncomeTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(annualIncomeDataLabel)
            make.top.equalTo(annualIncomeDataLabel.snp.bottom).offset(10)
            make.width.equalTo(annualWidth)
            make.height.equalTo(12)
        }
        
        investDateDataLabel.snp.makeConstraints { (make) in
            make.left.equalTo(annualIncomeDataLabel.snp.right).offset(10)
            make.bottom.equalTo(annualIncomeDataLabel)
            make.width.equalTo(otherWidth)
            make.height.equalTo(24)
        }
        
        investDateTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(investDateDataLabel)
            make.top.equalTo(investDateDataLabel.snp.bottom).offset(10)
            make.width.equalTo(otherWidth)
            make.height.equalTo(12)
        }
        
        remainingAmountDataLabel.snp.makeConstraints { (make) in
            make.left.equalTo(investDateDataLabel.snp.right).offset(10)
            make.bottom.equalTo(investDateDataLabel)
            make.width.equalTo(otherWidth)
            make.height.equalTo(16)
        }
        
        remainingAmountTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(remainingAmountDataLabel)
            make.top.equalTo(remainingAmountDataLabel.snp.bottom).offset(10)
            make.width.equalTo(otherWidth)
            make.height.equalTo(12)
        }
        
        // 项目进度
        backView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.equalTo(leftMargin)
            make.width.equalToSuperview().offset(-2 * leftMargin)
            make.height.equalTo(1)
            make.top.equalTo(annualIncomeTitleLabel.snp.bottom).offset(10)
        }
        
        // 8.起投金额
        backView.addSubview(staInvestAmountLable)
        staInvestAmountLable.snp.makeConstraints { (make) in
            make.left.equalTo(leftMargin)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // 分隔线
        backView.addSubview(separateLine)
        separateLine.snp.makeConstraints { (make) in
            make.left.equalTo(staInvestAmountLable.snp.right).offset(5)
            make.centerY.equalTo(staInvestAmountLable)
            make.height.equalTo(16)
            make.width.equalTo(LineThick)
        }
        
        // 产品标签
        backView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(separateLine.snp.right).offset(5)
            make.centerY.equalTo(separateLine)
        }
        
        // 9.购买按钮
        backView.addSubview(purchaseButton)
        purchaseButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-leftMargin)
            make.centerY.equalTo(tagLabel)
            make.height.equalTo(24)
            make.width.equalTo(70)
        }
        
        // 底部线条
        let footerLineView = UIView()
        footerLineView.backgroundColor = LineColor
        backView.addSubview(footerLineView)
        footerLineView.snp.makeConstraints { (make) in
            make.left.bottom.width.equalToSuperview()
            make.height.equalTo(LineThick)
        }
    }
}
