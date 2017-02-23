//
//  HomeModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class HomeModel: BaseModel {

    // banner数组
    //@property (nonatomic, strong) NSArray * bannersList;
    // 互助列表
    var productHzList: Array<CooperationModel> = []
    // 众筹列表
    var productZcList: Array<CrowdfundingModel> = []
    // 推荐标数组
    var productList: Array<ProductModel> = []
    // 砸金蛋url 目前已无用
    var dtUrl = ""
    // 活动是否开启
    var isAllowShown = false
    // 是否已显示过活动
    var isHasShown = false
    // 是否登陆 0-未登陆 1-登陆
    var isLogin = false
    // 是否显示新手模块 0-不显示1-显示
    var isShowXsModel = false
    // 平台累计投资金额
    var platformAllAmount = ""
    // 平台累计注册人数
    var platformRegisterNum = ""
    // 个人累计收益
    var sumRevenue = ""
    // 运营报告连接地址
    var yyUrl = ""
    // 未读消息数
    var unreadMessageCount = 0
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["productList" : ProductModel.self, "productHzList" : CooperationModel.self, "productZcList" : CrowdfundingModel.self]
    }
    
    class func getHomeData(block: @escaping responsedDataBlock) {
        NetAPIManager.shared.request(path: HomeRecommendUrl, params: nil, methodType: NetworkMethod.Get) { (response, error) in
            
            var data: Any?
            if error == nil {
                let dto = BaseDto.mj_object(withKeyValues: response)
                if let dic = dto?.data as? Dictionary<String, Any> {
                    let model = HomeModel()
                    data = model.mj_setKeyValues(dic)
                }
            }
            block(response, data, error)
        }
    }
}


