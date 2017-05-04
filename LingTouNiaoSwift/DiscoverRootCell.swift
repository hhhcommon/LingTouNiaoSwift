//
//  DiscoverRootCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 2017/5/4.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import SDWebImage

class DiscoverRootCell: UITableViewCell {

    let infoImageView = UIImageView.init()
    var banner: BannerModel? {
        get {
            return self.banner
        }
        set {
            if (newValue != nil) {
                if (newValue?.bannerPicture.hasPrefix("http"))! {
                    let url = URL(string: newValue!.bannerPicture)
                    self.infoImageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "placeholder_banner"), options: SDWebImageOptions.retryFailed)
                } else {
                    self.infoImageView.image = UIImage.init(named: newValue!.bannerPicture)
                }
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(infoImageView)
        infoImageView.snp.makeConstraints { (make) in
            make.left.equalTo((ScreenWidth - adaptiveBaseIphone6(350))/2)
            make.top.equalTo(0)
            make.width.equalTo(adaptiveBaseIphone6(350))
            make.height.equalTo(185)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
