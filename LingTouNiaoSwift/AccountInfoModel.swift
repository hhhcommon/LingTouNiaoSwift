//
//  AccountInfoModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class AccountInfoModel: BaseModel {

    // 鸟币待收收益
    var birdCoinRevenue: Double = 0
    // 鸟币
    var birdCoin: Double = 0
    // 待收本金
    var collectCapital: Double = 0
    // 待收收益
    var collectRevenue: Double = 0
    // 冻结金额
    var frozenAmount: Double = 0
    // 活期金额
    var liveAmount: Double = 0
    // 累积收益
    var sumRevenue: Double = 0
    // 未读消息数
    var unreadMessageCount: Int = 0
    
    // 总资产
    var totalAsset: Double = 0
    // 可用余额
    var usableBalance: Double = 0
    // 用户编号
    var userId: Double = 0
    // 提现次数
    var freeCounter: Int = 0
    
    // 是否显示随心投
    var sxtIsShow: Bool = false
    // 是否显示安心投
    var axtIsShow: Bool = false
    
    // 我的理财金券可用数量
    var myCoupons: Int = 0
    // 我的当前投资个数
    var myOrder: Int = 0
    // 我的全部任务个数
    var myTask: Int = 0
    // 已完成的任务个数
    var myTasking: Int = 0
}
