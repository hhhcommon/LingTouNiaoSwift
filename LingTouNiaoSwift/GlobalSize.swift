//
//  GlobalSize.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

// 常用尺寸
let ScreenScale = UIScreen.main.scale
// 通用尺寸 44
let GeneralSize: CGFloat = 44
// 线粗
let LineThick: CGFloat = 1 / UIScreen.main.scale
// 左右边距
let CommonMargin: CGFloat = 15

// 屏幕尺寸
// 目标屏幕的宽
let ScreenWidth = UIScreen.main.bounds.size.width
// 目标屏幕的高
let ScreenHeight = UIScreen.main.bounds.size.height
// 目标屏幕尺寸
let ScreenBounds = UIScreen.main.bounds
// 状态栏高度
let StatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
// 导航栏默认高度
let SystemNavigationHeight: CGFloat = 44
//    let NavigationBarHeight = self.navigationController.navigationBar.height

// 以iPhone6为基础适配
func adaptiveBaseIphone6(_ height: CGFloat) -> CGFloat {
    return height * ScreenWidth / 375
}

