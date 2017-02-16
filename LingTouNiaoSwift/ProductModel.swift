//
//  ProductModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class ProductModel: BaseModel {

    // 最后购买人
    var lastBuyer: String = ""
    var arrangeDate: String = ""
    // 是否可以预约
    var isArrange: String = ""
    var isFisrtPage: Int = 0
    // 投资最小递增倍数
    var multipleTequire: Double = 0
    // 产品ID
    var productId: Int = 0
    // 购买订单数
    var buyCount: Int = 0
    // 购买人数
    var buyPersonCount: Int = 0
    // 产品编号
    var productNo: String = ""
    // 产品名称
    var productName: String = ""
    // 产品类型
    var productType: String = ""
    // 年化收益
    var annualIncome: Double = 0
    // 年化收益字符串
    var annualIncomeText: String = ""
    // 产品标签
    var productTag: String = ""
    // 产品简介
    var productTitle: String = ""
    // 产品期限
    var productDeadline: Int = 0
    // 起投金额
    var staInvestAmount: Double = 0
    // 产品总金额
    var productTotalAmount: Double = 0
    // 产品剩余金额
    var productRemainAmount: Double = 0
    // 标的最大天数
    var convertDay: Int = 0
    // 产品期限单位
    var deadlineUnit: String = ""
    // 还款方式
    var repaymentType: String = ""
    // 起息日期 yyyy-MM-dd HH:mm:ss
    var staRateDate: String = ""
    // 起息计算方式
    var rateCalculateType: String = ""
    // 项目状态
    var productStatus: Int = 0
    // 募集结束时间 yyyy-MM-dd HH:mm:ss
    var raiseEndDate: String = ""
    // 标的发布时间 yyyy-MM-dd HH:mm:ss
    var bidPublishDate: String = ""
    // 满标时间 yyyy-MM-dd HH:mm:ss
    var overBidDate: String = ""
    // 流标时间 yyyy-MM-dd HH:mm:ss
    var offBidDate: String = ""
    // 排序号
    var orderNo: Int = 0
    // 创建时间 yyyy-MM-dd HH:mm:ss
    var createDate: String = ""
    // 创建人
    var createBy: String = ""
    // 提取手续费用
    var extractCharge: Double = 0
    // 提取限额
    var extractChargeLimit: Double = 0
    // 项目详情url地址
    var detailsUrl: String = ""
    //是否浮动标的
    var floatTag: Bool = false
    // 剩余可投资金额number
    var lastAmount: Double = 0
    // 单笔限额number
    var singleLimitAmount: Double = 0
    // 浮动标的最小天数
    var standardConvertDay: Int = 0
    // 单人累计限额number
    var totalLimitAmount: Double = 0
    // 是否支持用鸟币
    var useBirdCoinTag: Bool = false
    //优惠券支持
    var useCouponTag: Bool = false
    
    // MARK: - fuction
    // 起投金额 标的起投金额与标的剩余金额最小值
    func startAmount() -> Double {
        return min(self.staInvestAmount, self.productRemainAmount)
    }
    
    // 此标的用户最大可投金额
    func getOnceMaxAccount() -> Double {
        
        //    第一步，确定起投金额，一般就是1000，但如果标的剩余金额小于1000，那么起投金额就是标的剩余的金额
        let aAmount: Double = self.startAmount()
        
        //    第二步，确定用户自己最大的可投金额：若余额 > 鸟币 * 5，默认值 = 余额 + 鸟币，向下取整；若余额 < 鸟币 * 5，默认值 = 余额 * 1.2，向下取整
        // 可用余额
        let usableBalance = (CurrentUser.mine.accountInfo?.usableBalance)!
        var bAmount: Double = usableBalance
        
        if self.useBirdCoinTag {
            // 鸟币
            let birdCoin = (CurrentUser.mine.accountInfo?.birdCoin)!
            bAmount = usableBalance >= birdCoin * 5 ? floor(usableBalance + birdCoin) : floor(usableBalance * 1.2)
        }
        
        //    第三步，确定项目当前的剩余金额
        let cAmount: Double = productRemainAmount
        
        //    第四步，确定项目是否存在单笔投资上限
        let dAmount: Double = self.hasSingleLimitAmount() ? singleLimitAmount : Double(MAXFLOAT)
        
        //    第五步，确定项目是否存在单人上限，计算出用户剩下可以投的金额
        let eAmount: Double = self.hasTotalLimitAmount() ? lastAmount : Double(MAXFLOAT)
        
        // 若b < a，或e < a，都取a；当b和e同时大于a，取b，c，d，e中的最小值
        var purchaseMaxAmount: Double = 0
        if bAmount <= aAmount || eAmount <= aAmount {
            purchaseMaxAmount = aAmount
        } else {
            let array = [bAmount, cAmount, dAmount, eAmount]
            for amount in array {
                if purchaseMaxAmount > amount {
                    purchaseMaxAmount = amount
                }
            }
        }
        
        return purchaseMaxAmount;
    }
    
    func hasSingleLimitAmount() -> Bool {
        if singleLimitAmount == 0 {
            return false
        }
        return true
    }
    
    func hasTotalLimitAmount() -> Bool {
        if totalLimitAmount == 0 {
            return false
        }
        return true
    }
    
    func deadlineString() -> String {
        if floatTag {
            return "\(standardConvertDay)-\(convertDay)"
        } else {
            return "\(productDeadline)"
        }
    }
    
    // 是否为还款中
    func isRepaymenting() -> Bool {
        return self.productStatus >= 2 && !(self.productType == "TYB")
    }
}
