//
//  GlobalAppearance.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

// 字体
func normalFont(_ fontSize: CGFloat) -> UIFont {
    return CustomerizedFont.heiti(fontSize: fontSize)
}

func boldFont(_ fontSize: CGFloat) -> UIFont {
    return CustomerizedFont.boldHeiti(fontSize: fontSize)
}

//func stringSize(string: String, fontSize: CGFloat) -> CGSize {
//    return string
//}
//#define kFont(size)  [CustomFont heiti:size]
//#define kStringSize(string, fontSize) [string sizeWithAttributes:@{NSFontAttributeName : kFont(fontSize)}]
//
//#pragma mark 常用字体大小
//
//#define kFont18 kFont(18)
//#define kFont16 kFont(16)
//#define kFont14 kFont(14)
//#define kFont12 kFont(12)
//#define kFont11 kFont(11)

// 颜色
// 常用颜色
let ColorF9F9F9 = UIColor.colorWithHex(hex: 0xF9F9F9)   // 用于页面底部颜色&互助众筹加入按钮等
let ColorEFEFEF = UIColor.colorWithHex(hex: 0xEFEFEF)   // 用于页面模块间的分隔线&单独线条隔断等
let ColorFFFDE4 = UIColor.colorWithHex(hex: 0xFFFDE4)   // 用于底部投资按钮上方提示语背景
let ColorECECEC = UIColor.colorWithHex(hex: 0xECECEC)   // 用于每个标的底色，标的进度条灰色
let ColorFAB51C = UIColor.colorWithHex(hex: 0xFAB51C)   // 用于标的进度颜色
let Color83C940 = UIColor.colorWithHex(hex: 0x83C940)   // 用于注册成功辅助色
let Color666666 = UIColor.colorWithHex(hex: 0x666666)   // 用于详情简介文字、项目标题文字
let Color999999 = UIColor.colorWithHex(hex: 0x999999)   // 用于较浅的说明文字
let Color333333 = UIColor.colorWithHex(hex: 0x333333)   // 用于较深标题颜色及列表标题文字颜色
let Color4A90E2 = UIColor.colorWithHex(hex: 0x4A90E2)   // 用于投资协议等连接提示文字

let NavigationBarColor = UIColor.white
let LineColor = ColorEFEFEF
let MainColor = UIColor.colorWithHex(hex: 0xFF6600)
let NavigationTintColor = MainColor
let BackgroundColor = ColorF9F9F9
let DisabledColor = UIColor.colorWithHex(hex: 0xCCCCCC)
let LinkColor = Color4A90E2
let WhiteColor = UIColor.white

