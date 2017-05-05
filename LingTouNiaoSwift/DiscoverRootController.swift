//
//  DiscoverRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/3.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class DiscoverRootController : BaseTableViewController {

    lazy var data: Array<Dictionary<String, Any>> = {
        
        var activeBanner = BannerModel()
        activeBanner.bannerPicture = "placeholder_banner"
        
        var crowdfundingBanner = BannerModel()
        crowdfundingBanner.bannerPicture = "zhongchou"
        
        var cooperationBanner = BannerModel()
        cooperationBanner.bannerPicture = "huzhu"
        
        var data = [["title" : "热门活动",
                     "value" : [activeBanner]],
                    ["title" : "众筹互助",
                     "value" : [crowdfundingBanner, cooperationBanner]]]
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        self.registerCell()
        self.loadData()
    }
    
    func registerCell() {
        self.tableView.register(DiscoverRootCell.classForCoder(), forCellReuseIdentifier: "DiscoverRootCell")
    }
    
    func loadData() {
        var bannerList: Array<BannerModel>?
        let activeData: NSData? = UserDefaults.standard.value(forKey: BannerHomeAndBannerIntroduction) as? NSData
        if activeData != nil {
            bannerList = NSKeyedUnarchiver.unarchiveObject(with: activeData! as Data) as? Array<BannerModel>
            if bannerList != nil && (bannerList?.count)! > 0 {
                var activeDic: Dictionary = self.data.first!
                activeDic.updateValue(bannerList!, forKey: "value")
                self.data[0] = activeDic
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let banners: Array<BannerModel> = self.data[section]["value"] as! Array<BannerModel>
        return banners.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DiscoverRootCell(style: UITableViewCellStyle.default, reuseIdentifier: "DiscoverRootCell")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let bannerValues: Array<BannerModel> = data[indexPath.section]["value"] as! Array<BannerModel>
        cell.banner = bannerValues[indexPath.row] 
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.data[section]["title"] as? String
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = WhiteColor
        
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = Color333333
        headerView.textLabel?.font = normalFont(16)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185 + 5;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            self.goToCrowdfundingListController()
        } else if indexPath.section == 1 && indexPath.row == 1 {
            self.goToCooperationListController()
        } else {
            // todo：
            // 跳转到h5
        }
    }
    
    func goToCooperationListController() {
        print("互助列表")
//        LTNCooperationListController *CooperationList = [[LTNCooperationListController alloc]init];
//        CooperationList.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:CooperationList animated:YES];
    }
    
    func goToCrowdfundingListController() {
        print("众筹列表")
//    LTNCrowdfundingListController *CrowdfundingList = [[LTNCrowdfundingListController alloc]init];
//    CrowdfundingList.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:CrowdfundingList animated:YES];
    }

}
