//
//  CrowdfundingListModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class CrowdfundingListModel: NSObject {

    var crowdfundingList: Array<CrowdfundingModel>?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["productZcList" : CrowdfundingModel.self]
    }
    
    //    class func getCrowdfundingList(params: Dictionary<String, Any>, block: @escaping responsedDataBlock) {
    //        NetAPIManager.shared.request(path: ProductsListUrl, params: params, methodType: NetworkMethod.Get) { (response, error) in
    //            var data: Any?
    //            if response != nil {
    //                let dto = BaseDto.mj_object(withKeyValues: response)
    //                let model = ProductListModel()
    //                data = model.mj_setKeyValues(dto?.data)
    //            }
    //            block(response, data, error)
    //        }
    //    }
}
