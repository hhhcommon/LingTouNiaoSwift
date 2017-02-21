//
//  CooperationModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class CooperationModel: BaseModel {

    var createTime: Double = 0  // 创建时间
    var hzDetailUrl = ""	// 互助详情页
    var isFirstPage = false //是否首页显示@mock=0
    var productContent = ""  //产品详情
    var productDesc = ""     //产品描述@mock=asaaa
    var productFirstTitle = ""   //引导页主标题
    var productId = 0  //产品id
    var productMaxpayAmount: Double = 0    //最高赔偿金额
    var productName = "" //产品名称
    var productNo = ""	//产品编号
    var productPic = ""	//详情页图片
    var productTopPic = ""   // 简介图片
    var productSoldedAmount: Double = 0 // 已投金额
    var productStatus = ""   //产品状态i，跟标的状态一样
    var productSubTitle = "" //引导页副标题
    var productTotalAmount: Double = 0 //产品总金额
    var productType = "" //产品类型
    var productWiki = "" //wiki
    var remark = ""
    var singleLimitAmount = ""   //单笔限制金额，即起投金额
    var sortNo = 0 //排序
    var useBridCoinTag = false  //是否使用鸟币
    var useCouponTag = false   //是否能使用返现券
    var useEquipment = 0;   //平台类型 1-PC 2-APP
    var waitDays: Double = 0   //等待日期
}
