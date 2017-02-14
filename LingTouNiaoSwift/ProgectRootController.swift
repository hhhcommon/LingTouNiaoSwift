//
//  ProgectRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/3.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class ProgectRootController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.creatControllers()
    }
    
    func creatControllers() {
        // 1.首页
        let home = HomeRootController()
        let homeNav = BaseNavigationController(rootViewController: home)
        let homeItem = UITabBarItem.init(title: "首页", image: UIImage.init(named: "tab_home_normal"), selectedImage: UIImage.init(named: "tab_home_selected"))
        home.tabBarItem = homeItem
        
        // 2.投资理财
        let investment = InvestmentRootController()
        let investmentNav = BaseNavigationController(rootViewController: investment)
        let investmentItem = UITabBarItem.init(title: "理财", image: UIImage.init(named: "tab_list_normal"), selectedImage: UIImage.init(named: "tab_list_selected"))
        investmentNav.tabBarItem = investmentItem
        
        //3.发现
        let discover = DiscoverRootController()
        let discoverNav = BaseNavigationController(rootViewController: discover)
        let discoverItem = UITabBarItem.init(title: "发现", image: UIImage.init(named: "tab_discover_normal"), selectedImage: UIImage.init(named: "tab_discover_selected"))
        discoverNav.tabBarItem = discoverItem
        
        // 4.我的帐号
        let account = AccountRootController()
        let accountNav = BaseNavigationController(rootViewController: account)
        let accountItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "tab_account_normal"), selectedImage: UIImage.init(named: "tab_account_selected"))
        accountNav.tabBarItem = accountItem
        
        let controllers = [homeNav, investmentNav, discoverNav, accountNav]
        self.viewControllers = controllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let naviController = viewController as! UINavigationController
        if naviController.topViewController is AccountRootController {
            if CurrentUser.mine.hasLogged() {
                return true
            } else {
                ControllersManager.shared.loginController(finishBlock: { () in
                    self.selectedIndex = 3
                })
                return false
            }
        }
        return true
    }
}
