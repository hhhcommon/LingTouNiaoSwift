//
//  HomeRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

private let ProductListCellIdentify = "ProductListCell"
private let CrowdfundingCellIdentify = "CrowdfundingCell"
private let CooperationCellIdentify = "CooperationCell"
private let HomeLoanCellIdentify = "HomeLoanCell"
private let HomeDivisionCellIdentify = "HomeDivisionCell"
private let HomeBannerCellIdentify = "HomeBannerCell"

class HomeRootController: BaseViewController, UITableViewDataSource, UITableViewDelegate, HomeHeaderViewDelegate {

    var tableView: UITableView?
    var homeHeaderView: HomeHeaderView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.loadData()
        self.setTableView()
        self.registerCell()
        self.addNotifications()
    }
    
    func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshUI),    name: NSNotification.Name(rawValue: LoginSuccessNotification), object: nil)
    }
    
    func refreshUI() {
        
    }
    
    func loadData() {
//        let params = ["pageSize": pageSize, "currentPage": currentPage]
//        ProductListModel.getProductList(params: params) { (response, productList, error) in
//            if productList != nil {
//                let productList = productList as! ProductListModel
//                self.sourceData = productList.productList!
//                self.tableView?.reloadData()
//            }
//        }
    }
    
    func setTableView() {
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.grouped)
        tableView!.backgroundColor = UIColor.white
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.none
        homeHeaderView = HomeHeaderView.getHomeHeaderViewWithDelegate(delegate: self)
        tableView!.tableHeaderView = homeHeaderView
        self.view.addSubview(tableView!)
    }
    
    func registerCell() {
        tableView!.register(ProductListCell.classForCoder(), forCellReuseIdentifier: ProductListCellIdentify)
        tableView!.register(HomeLoanCell.classForCoder(), forCellReuseIdentifier: HomeLoanCellIdentify)
        tableView!.register(HomeDivisionCell.classForCoder(), forCellReuseIdentifier: HomeDivisionCellIdentify)
        tableView!.register(CooperationCell.classForCoder(), forCellReuseIdentifier: CooperationCellIdentify)
        tableView!.register(CrowdfundingCell.classForCoder(), forCellReuseIdentifier: CrowdfundingCellIdentify)
        tableView!.register(HomeBannerCell.classForCoder(), forCellReuseIdentifier: HomeBannerCellIdentify)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = ProductListCell(style: UITableViewCellStyle.default, reuseIdentifier: "ProductListCell")
        let cell = HomeLoanCell(style: UITableViewCellStyle.default, reuseIdentifier: "HomeLoanCell")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        cell.product = sourceData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
}
