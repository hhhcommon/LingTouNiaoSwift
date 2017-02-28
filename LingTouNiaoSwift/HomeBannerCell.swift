//
//  HomeBannerCell.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let BannerCellHeight = adaptiveBaseIphone6(180)

@objc protocol HomeBannerCellDelegate {
    @objc optional func clickBanner(bannerView: BannerView, banner: BannerModel)
}

class HomeBannerCell: UITableViewCell, BannerViewDelegate {

    var delegate: HomeBannerCellDelegate?
    let bannerView = BannerView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: BannerCellHeight))
    var data: Array<BannerModel> {
        get {
            return self.data
        }
        set {
            if newValue.count > 0 {
                bannerView.delegate = self
                bannerView.bannersList = newValue
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.addSubview(self.bannerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func clickBanner(bannerView: BannerView, banner: BannerModel) {
        self.delegate?.clickBanner!(bannerView: bannerView, banner: banner)
    }

}
