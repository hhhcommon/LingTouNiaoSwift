//
//  BannerModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class BannerModel: BaseModel {

    // banner id
    var bannerId = ""
    // banner名字
    var bannerName = ""
    // Banner状态
    var bannerState = false
    // banner跳转地址
    var bannerUrl = ""
    // banner内容
    var bannerContent = ""
    // banner图片地址
    var bannerPicture = ""
    // banner标题
    var bannerTitle = ""
    // banner类型
    var forModel = ""
    
    
    // 是否分享 1表示分享，0表示不分享
    var isShare = false
    // 分享名字
    var shareTitle = ""
    // 分享内容
    var shareContent = ""
    // 分享图片
    var sharePic = ""
    // 分享链接
    var shareUrl = ""
    
}
