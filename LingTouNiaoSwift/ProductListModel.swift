//
//  ProductListModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class ProductListModel: BaseModel {

    var productList: Array<ProductModel>?

    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["productList" : ProductModel.self]
    }
    
    class func getProductList(params: Dictionary<String, Any>, block: @escaping responsedDataBlock) {
        NetAPIManager.shared.request(path: ProductsListUrl, params: params, methodType: NetworkMethod.Get) { (response, error) in
            var data: Any?
            if response != nil {
                let dto = BaseDto.mj_object(withKeyValues: response)
                let model = ProductListModel()
                data = model.mj_setKeyValues(dto?.data)
            }
            block(response, data, error)
        }
    }
    
    func sort(array: Array<ProductModel>) -> Array<ProductModel> {
        /*
         加息标在前
         投资期限短的在前
         */
        // 1.区分加息标和非加息标
        var JXBArray: Array<ProductModel> = Array()
        var NJXBArray: Array<ProductModel> = Array()
        for product in array {
            let range = product.annualIncomeText.range(of: "+")
            if range != nil && range!.upperBound == range!.lowerBound {
                JXBArray.append(product)
            } else {
                NJXBArray.append(product)
            }
        }
        
        // 2.两类标的按投资期限排序
        // TODO: 如果是浮动期限，该如何排序
        JXBArray.sort { (product1, product2) -> Bool in
            // 从小到大排
            return product2.convertDay > product1.convertDay
        }
        NJXBArray.sort { (product1, product2) -> Bool in
            // 从小到大排
            return product2.convertDay > product1.convertDay
        }
        
        return JXBArray + NJXBArray
    }
}
