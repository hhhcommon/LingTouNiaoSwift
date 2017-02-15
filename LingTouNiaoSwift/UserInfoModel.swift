//
//  UserInfoModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class UserInfoModel: BaseModel {

    // 用户id
    var userId: String = ""
    // 用户姓名
    var userName: String = ""
    // 手机号
    var mobile: String = ""
    // 手机推送码
    var deviceToken: String = ""
    // 实名认证标志 0：未实名1：已实名
    var certification: String = ""
    // 身份证
    var cardId: String = ""
    // 状态
    var state: String = ""
    // 联动优势开户日期
    var regDate: String = ""
    // 推荐码
    var referralCode: String = ""
    // 银行卡认证状态 0：未实名1：已实名
    var bankAuthStatus: String = ""
    // 投资状态
    var investStatus: String = ""
    // 联动用户号
    var umpayUserNo: String = ""
    // 联动账户号
    var umpayAccountNo: String = ""
    // 客户类型
    var guestType: String = ""
    // 客户等级
    var userLevelId: String = ""
    // 是否已经体验 0：未体验；1：已体验
    var isExperience: Bool = false
    // 是否内部员工
    var isStaff: Bool = false
    // 是否首次下单
    var isFirstOrder: Bool = false
    // 银行卡号
    var bankNo: String = ""
    // 银行卡名称
    var belongBank: String = ""
    // 银行图标
    var logoUrl: String = ""
    // 银行预留手机号码
    var preMoblieNo: String = ""
    //是否开通免密充值
    var agreementCZ: Bool = false
    //是否开通免密投资
    var agreementTZ: Bool = false
    
    // MARK: - function
    func sex() -> String {
        
        let cardID = NSString.init(string: cardId)
        if cardId.characters.count == 18 {
            let sexString: NSString = (cardID as NSString).substring(with: NSMakeRange(16, 1)) as NSString
            let sexNum = sexString.intValue
            return sexNum % 2 == 0 ? "1" : "0"
        }
        
        if cardId.characters.count == 15 {
            let sexString: NSString = (cardID as NSString).substring(with: NSMakeRange(14, 1)) as NSString
            let sexNum = sexString.intValue
            return sexNum % 2 == 0 ? "1" : "0"
        }
        
        return ""
    }
}
