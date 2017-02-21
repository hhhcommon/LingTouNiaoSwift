//
//  BannerListModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class BannerListModel: BaseModel {

    var bannerList: Array<BannerModel>?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["bannerList" : BannerModel.self]
    }
    
}
