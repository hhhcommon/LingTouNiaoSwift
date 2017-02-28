//
//  CommonApi.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/24.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

func GetBannerList(block: responsedDataBlock?) {
    let dic = ["location" : 0]
    NetAPIManager.shared.request(path: BannerList, params: dic, methodType: NetworkMethod.Get, autoShowError: false) { (response, error) in
        var data: Any?
        if response != nil {
            let dto = BaseDto.mj_object(withKeyValues: response)
            let model = BannerListModel()
            data = model.mj_setKeyValues(dto?.data)
            var arrayHome: Array<BannerModel> = []
            var arrayCooperation: Array<BannerModel> = []
            var arrayCrowding: Array<BannerModel> = []
            var arrayLoan: Array<BannerModel> = []
            var arrayTask: Array<BannerModel> = []
            if let listModel = data as? BannerListModel {
                for banner in listModel.bannerList! {
                    if banner.forModel == "1" {//首页
                        arrayHome.append(banner)
                    } else if banner.forModel == "2" {//互助
                        arrayCooperation.append(banner)
                    } else if banner.forModel == "3" {//众筹
                        arrayCrowding.append(banner)
                    } else if banner.forModel == "4" {//借款
                        arrayLoan.append(banner)
                    } else if banner.forModel == "5" {//任务
                        arrayTask.append(banner)
                    }
                }
            }
            UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: arrayHome), forKey: BannerHomeAndBannerIntroduction)
            UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: arrayCooperation), forKey: BannerCooperationAndBannerIntroduction)
            UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: arrayCrowding), forKey: BannerCrowdingAndBannerIntroduction)
            UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: arrayLoan), forKey: BannerLoanAndBannerIntroduction)
            UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: arrayTask), forKey: BannerTaskAndBannerIntroduction)
        }
        block?(response, data, error)
    }
}
