//
//  ControllersManager.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/30.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class ControllersManager: NSObject {
    static let sharedManager = ControllersManager()
    private override init() {}
    func setupProjectRootViewController() {
        GlobalManager.mainWindow().rootViewController = ProgectRootController()
    }
}

