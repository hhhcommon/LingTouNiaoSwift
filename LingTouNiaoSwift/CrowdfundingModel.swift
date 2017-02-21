//
//  CrowdfundingModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class CrowdfundingModel: BaseModel {

    var annualIncome: Double = 0   //年华收益，如：0.01,0.11
    var annualIncomeText = ""    //年化显示,如'2%','11%'
    var beginTime = 0 //开始日期
    var convertDay = 0   //折算天
    var createTime = 0    //创建时间
    var createUserId = ""
    var endRateDate = 0
    var endTime = 0
    var isFirstPage = false //是否显示在首页
    var overBidDate = 0
    var productContent = ""  //产品详情
    var productDesc = "" //产品描述
    var productFirstTitle = ""   //引导页主标题
    var productId = 0  //产品id
    var productName = "" //产品名称
    var productNo = "" //产品编号
    var productRuleText = "" //产品规则
    var productSoldedAmount: Double = 0   //已投金额
    var productStatus = ""   //产品状态i，跟标的状态一样
    var productSubTitle = "" //产品副标题
    var productTopPic = ""   //首页配图,eg:'http://123132.jpg','http://123132.jpg'
    var productPic = ""  // 众筹列表图片
    var productTotalAmount: Double = 0    //产品总金额
    var productType = "" //产品类型
    var productWiki = "" //wiki
    var raiseEndDate = 0  // 募集结束日期
    var remark = ""
    var sortNo = 0 //排序
    var staInvestAmount: Double = 0   // 起投金额
    var staRateDate = 0
    var updateTime = 0
    var updateUserId = 0
    var useBridcoinTag = false  //是否使用鸟币
    var useCouponTag = false    //是否能使用返现券
    var useEquipment = 0   //平台类型 1-PC 2-APP
    var zcDetailUrl = ""    // 众筹详情url
}
