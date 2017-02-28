//
//  RescourceManager.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/24.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class RescourceManager: NSObject {

    static let shared = RescourceManager()
    private override init() {}
    
    func getSyncRescource() {
        // 获取银行列表
//        [LTNServerHelper retrieveBankListWithFinishBlock:nil];
        // 获取banner列表
//        GetBannerList { (response, data, error) in
//            if data != nil {
//                if let bannerLinst = data! as? BannerListModel {
//                    print("\(bannerLinst.bannerList)")
//                } else {
//                    print("no bannerLinst")
//                }
//            }
//        }
        GetBannerList(block: nil)
        
        // 更新启动页
//        [self updateLaunch];
    }
}
