//
//  APIUrlConstants.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/17.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import Foundation

func getCachePaths() -> Array<String> {
    let cachePaths = [""];
    return cachePaths
}

/**
 *  网络接口
 */
// baseUrl：基地址
let API_BASE_URL = "http://192.168.18.194:8080"

// url：获取图片验证码
let GetPictureCaptchaUrl = "/user/register/pictureCode"
// url：获取手机短信验证码
let GetMobileCaptchaUrl = "/mobile/mobilecode/getMobileCode"
//@"user/login/mobileCode"
// url：用户注册
let UserRegisterUrl = "/user/register/registerUser"
// url：用户登录
let UserLoginUrl = "/user/login/login"
// url：修改密码
let ModifyPasswordUrl = "/user/login/editPwd"
// url：找回密码（忘记密码）
let RetrievePasswordUrl = "/user/login/retrievePwd"
// url：服务端验证短信验证码
let VerifyMobileCodeUrl = "/mobile/mobilecode/verifyMobileCode"
// url：用户推出
let UserLogoutUrl = "/user/login/logout"
// url：首页推荐产品和banner
let HomeRecommendUrl = "/homepage/recommendnew"
// url：产品列表
let ProductsListUrl = "/product/lists"
// url: 产品详情
let ProductsDetailUrl = "/productDetail"
// url：确认购买产品
let UserOrderOrderPrepareUrl = "/user/order/orderPrepare"
// url: 互助下单准备
let UserOrderhzOrderhzprepareUrl = "/user/orderhz/orderhzprepare"
// url: 互助确认下单
let UserOrderconfirmUrl = "/user/orderconfirm"
// url: 众筹下单准备
let OrderZcOrderZcPrepareUrl = "/orderZc/orderZcPrepare"
// url: 众筹确认下单
let ProductZcOrderSubmitUrl = "/product/zc/order/submit"
// url：2.4 我要理财—确认购买 （体验标＋虚拟标）
let BuyProductConfirmUrl = "/product/buy/confirm"
// url：我的账户
let UserAccountUrl  = "/user/account/myAccount"
// url：我的账户-免费提现次数
let UserAccountContainFreeCountUrl = "/user/account/myAccount/freeCount"
// url: 我的帐户拆分
let UserAccountSpiltUrl = "/user/account/myAccountAffiliated"
// url：账户信息
let UserAccountInfoUrl = "/user/account/userInfo"
// url：我的投资
let UserInvestUrl = "/user/account/orders"
// url：我的理财金券
let UserCouponUrl = "/user/account/myFinancialCoupon"
//url:  用户实名制
let UserAuthUrl = "/user/register/userAuthPwd"
// url: 总资产
let TotalAccountUrl = "/user/account/totalaccount"
// url: 鸟币明细
let BirdCoinAmountUrl = "/user/account/birdCoinAmount"
// url: 余额明细
let BalanceDetailUrl = "/account/balanceDetail"
// url: 购买记录
let PurchaseHistoryUrl = "/product/purchasehistory"
//url:  获取银行卡限额
let LimitAmountUrl = "/bank/limitAmount"
//url:  绑卡--[需要去联动网页]
let UserBindBankCardUrl = "/user/bindBankCard"
//url:  充值-[需要去联动网页]
let UserRechargeUrl = "/user/recharge"
//url:  提现-[需要去联动网页]
let UserWithdrawalseUrl = "/user/withdrawals"
//url:  收益明细
let UncRevenueUrl = "/user/uncRevenue"
//url:好友统计
let FriendsCountUrl = "/user/account/friends"
//url:合伙人
let PartnerUrl = "/user/partner"
//url:已发放奖励
let EarningUrl = "/user/partner/earnings"
//url:补充合伙人
let ReplenishUrl = "/user/partner/replenish"
// update
let CheckUpdateUrl = "/app/global/checkupdate"
//url:feedback
let FeedbackUrl = "/user/aboutus/feedback"
// user information
let UserInfoUrl = "/user/userInfo"
//银行卡列表
let BankBankList = "/bank/bankList"
//查看换卡状态
let ScheduleStatus = "/user/replaceBankCard/status"
//提交换卡的阅读结果
let HasReadDesStatus = "/user/replaceBankCard/read"
//my investiment
let MyInvestimentUrl = "/user/account/myInvestment"
// url:活期
let CurrentDepositUrl = "/product/current/homepage"
// url:活期转入
let CurrentRollInUrl = "/product/current/buy"
// url:活期转出
let CurrentRollOutUrl = "/product/current/extract"
// url:活期明细
let CurrentIncomeListUrl = "/user/current/incomeList"
// url:安心投列表
let FindOfflineOrder = "/product/findOfflineOrder"
// url:免密支付申请
let UserAgreeMianMiUrl = "/user/agreement"
//url:换卡申请
let ChangeCardUrl = "/user/replaceBankCard"
// url:获取金蛋接口
let GoldenEggGetUrl = "/goldenegg/get"
// url:砸蛋之后提交接口
let GoldenEggSubmitUrl = "/goldenegg/submit"
// url:消息中心数据接口
let MessageList = "/message/list"
// url :消息中心全读
let MessageRead = "/message/read"
// url:借款进度查询
let LoanQuery = "/loan/query"
// url:理财金券兑换
let ExchangeCode = "/user/exchangeCode/exchange"
// url:生成赠券码
let PresentCode = "/app/presentCoupon/presentCode/get"
// url:我的任务
let TaskListUrl = "/task/list"
// url:领取奖励
let TaskSubmitUrl = "/task/submit"
// url:任务状态进度
let TaskNum = "/task/num"
// url:检查是否完成任务
let TaskCheck = "/task/check"
// URL:可运营启动页
let FirstPage = "/firstPage"
// url:banner
let BannerList = "/page/banner"
// url:我的互助
let MyHelpUrl = "/help/myHelp"
// url:互助列表
let HelpListUrl = "/help/helpList"
// url:我的众筹
let OrderZcUrl = "/orderZc/myOrderZc"
// url:众筹列表
let ProductZcUrl = "/productZc/producZcSearch"
// url:众筹购买记录
let SearchOrderZc = "/orderZc/searchOrderZc"
// url:互助购买记录
let MemberListUrl = "/help/memberList"
// url:我的地址
let GetAddressUrl = "/addressManage/getAddress"
// url:编辑地址
let UpdateAddressUrl = "/addressManage/updateAddress"
// url:删除地址
let DelteAddressUrl = "/addressManage/delAddress"
// url:增加地址
let CreateAddressUrl = "/addressManage/addAddress"


/**
 *  h5页面
 */
// 安全保障
let H5InsuranceUrl = "/h5/insurance.html"
// 首页风险备用金
let H5ReservefundUrl = "/h5/reservefund.html"
// 关于领投鸟
let H5AboutUrl = "/h5/about.html"
// 帮助中心
let H5HelpCenter = "/h5/help-center.html"
//鸟币帮助
let H5BirdCoinHelp = "/h5/help-money-use.html"
// 砸金蛋
let H5Drawaward = "/h5/drawaward.html"


// 同意协议书
let H5AcceptUrl = "/h5/accept-register.html"
// 身份认证协议
let H5Accept_IDUrl = "/h5/accept-id.html"
// 绑定银行卡
let H5AcceptBindUrl = "/h5/accept-bind.html"
// 随心投协议书
let H5AcceptCurrentUrl = "/h5/project-accept-current.html"


// 产品分享链接
let H5ShareUrl = "/h5/share.html"
// 首页信托
let H5ProfitUrl = "/h5/profit.html"

// 会员公约
let H5HuiyuanUrl = "/h5/protocol/vipProtocol/protocol.html"
// 奖励规则
let H5RewardruleUrl  = "/h5/rewardrule.html"
// 合伙人特权
let H5PartnerUrl  = "/native/app_partner/app_partner.html"
//提现说明
let H5WithDrawIntroUrl  = "/h5/withdrawintro.html"
//跳往成功界面
let H5ProjectTransferUrl  = "/h5/success-invest.html"
// 随心投转入成功界面
let H5CurrentTransferinUrl  = "/h5/success-transferin.html"
// 联动介绍
let H5AboutUmpayUrl = "/h5/link-info.html"
// 新手指引
let H5IntroGuideUrl = "/h5/newsguid.html"
//借款列表
let LoanShow = "/loan/loanType"
//借款
let RequestLoan = "/loan/submit"
// 借款开关
let LoanSettingUrl = "/loan/loanSetting"

//银行异常信息
let BankListNotice = "/bank/bankList/notice"

//tips信息
let SysConfig = "/sys/sysConfig"

//tips信息
let StaticSource = "/staticSource"


//合法域名
let LegalDomain = "/mobile/mobiledomain"

//赠送码获得金券

let PresentCoupon = "/app/presentCoupon/couponInfo/get"

