//
//  HomeLoanCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/17.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let HomeLoanCellHeight: CGFloat = adaptiveBaseIphone6(75)

class HomeLoanCell: UITableViewCell {
  
    private let Margin: CGFloat = 12.5
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllSubviews() {
        let loanImage = UIImage.init(named: "jiekuan")
        let loanImageView = UIImageView.init(image: loanImage)
        self.contentView.addSubview(loanImageView)
        
        let lineView = UIView()
        lineView.backgroundColor = LineColor
        self.contentView.addSubview(lineView)
        
        let insets = UIEdgeInsets(top: Margin * 0.5, left: Margin, bottom: Margin, right: Margin)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(insets)
            make.top.equalToSuperview()
            make.height.equalTo(1.0 / ScreenScale)
        }
        loanImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(insets)
            make.width.equalTo(loanImageView.snp.height).multipliedBy((loanImage?.size.width)! / (loanImage?.size.height)!)
        }
    }
}
