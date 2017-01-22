//
//  RegisterController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/3.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class RegisterController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        let registerView = RegisterView()
        view.addSubview(registerView)
        registerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
