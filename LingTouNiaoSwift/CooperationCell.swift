//
//  CooperationCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import SDWebImage

let CooperationCellHeight  = adaptiveBaseIphone6(210)
private let Margin = adaptiveBaseIphone6(15)
private let RatioOfTopAndBottom = (145.0 / 65.0)

class CooperationCell: UITableViewCell {

    var hideJoin: Bool {
        get {
            return self.hideJoin
        }
        set {
            joinLabel.isHidden = newValue
        }
    }
    
    var data: CooperationModel {
        get {
            return self.data
        }
        set {
            self.refresh(data: newValue)
        }
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(15)
        label.textColor = Color666666
//        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.textColor = Color999999
//        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var startInvestLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(16)
        label.textColor = Color666666
        label.textAlignment = NSTextAlignment.right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var joinLabel: UILabel = {
        let label = UILabel()
        label.font = normalFont(12)
        label.textColor = LinkColor
        label.textAlignment = NSTextAlignment.right
        label.text = "立即加入"
        return label
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
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
        self.contentView.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, Margin, 0, Margin))
        }
        
        let topView = UIView()
        backgroundView.addSubview(topView)
        
        let bottomView = UIView()
        backgroundView.addSubview(bottomView)
        
        topView.snp.makeConstraints { (make) in
            make.width.left.top.equalToSuperview()
            make.height.equalTo(CooperationCellHeight).offset(-bottomView.height)
            make.height.equalTo(bottomView).multipliedBy(RatioOfTopAndBottom);
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.width.left.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        
        topView.addSubview(contentImageView)
        
        contentImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bottomView.addSubview(titleLabel)
        bottomView.addSubview(detailLabel)
        bottomView.addSubview(startInvestLabel)
        bottomView.addSubview(joinLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(2.0 / 3.0).offset(-5)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.5);
            make.bottom.equalTo(bottomView.snp.centerY)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-60)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.5).offset(-5)
            make.top.equalTo(bottomView.snp.centerY).offset(5)
        }
        
        startInvestLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(1.0 / 3.0).offset(-5);
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.5);
            make.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        joinLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalTo(60)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.5).offset(-5);
            make.top.equalTo(bottomView.snp.centerY).offset(5)
        }
    }
    
    fileprivate func refresh(data: CooperationModel) {
        
        contentImageView.sd_setImage(with: URL(string: data.productTopPic), placeholderImage: UIImage.init(named: "placeholder_banner"))
        // 需要过滤html
        titleLabel.text = String.filterHTML(html: data.productFirstTitle)
        detailLabel.text = String.filterHTML(html: data.productSubTitle)
        let startInvest = String.filterHTML(html: data.singleLimitAmount)
        startInvestLabel.text = "\(startInvest)元起投"
        startInvestLabel.sizeToFit()
        let attributeString = startInvestLabel.text!.substring(to: startInvestLabel.text!.index((startInvestLabel.text?.endIndex)!, offsetBy: -4))
        startInvestLabel.attributedText = startInvestLabel.text?.configAttributesForString(attributes: [NSForegroundColorAttributeName : UIColor.colorWithHex(hex: 0xea3e00)], string: attributeString)
    }
}
