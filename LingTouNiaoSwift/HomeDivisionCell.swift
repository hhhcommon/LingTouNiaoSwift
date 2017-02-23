//
//  HomeDivisionCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let HomeDivisionCellHeight = adaptiveBaseIphone6(120)

class HomeDivisionCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAllSubviews() {
        
        let backgroundImageView = UIImageView.init(image: UIImage.init(named: "xszq"))
        self.contentView.addSubview(backgroundImageView)
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImageView.snp.makeConstraints { (make) in
            make.height.equalTo(HomeDivisionCellHeight)
            make.width.equalTo(HomeDivisionCellHeight).multipliedBy(backgroundImageView.image!.size.width / backgroundImageView.image!.size.height);
            make.center.equalToSuperview()
        }
    }
}
