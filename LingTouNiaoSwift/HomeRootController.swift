//
//  HomeRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

private let MyHomeModel = "MyHomeModel"
private let ProductListCellIdentify = "ProductListCell"
private let CrowdfundingCellIdentify = "CrowdfundingCell"
private let CooperationCellIdentify = "CooperationCell"
private let HomeLoanCellIdentify = "HomeLoanCell"
private let HomeDivisionCellIdentify = "HomeDivisionCell"
private let HomeBannerCellIdentify = "HomeBannerCell"

class HomeRootController: BaseViewController, UITableViewDataSource, UITableViewDelegate, HomeHeaderViewDelegate, HomeSectionHeaderViewDelegate, HomeBannerCellDelegate {

    var tableView: UITableView?
    var homeHeaderView: HomeHeaderView?
    var homeModel: HomeModel?
    var cellData: Array<Dictionary<String, Any>> = []
    
    // MARK: - life circle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        if let data = UserDefaults.standard.value(forKey: MyHomeModel) as? Data {
            self.homeModel = NSKeyedUnarchiver.unarchiveObject(with: data) as? HomeModel
            self.initCellDataWithHomeModel(homeModel: self.homeModel)
        }
        self.loadData()
        self.setTableView()
        self.registerCell()
        self.addNotifications()
    }
    
    // MARK: - private methods
    fileprivate func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name(rawValue: LoginSuccessNotification), object: nil)
    }
    
    @objc fileprivate func loadData() {
        var getDataSuccess = false
        HomeModel.getHomeData { (response, data, error) in
            if let homeModel = data as? HomeModel {
                self.homeModel = homeModel
                UserDefaults.standard.setValue(homeModel.platformAllAmount, forKey: PlatformAllAmount)
                UserDefaults.standard.setValue(homeModel.platformRegisterNum, forKey: PlatformRegisterNum)
                UserDefaults.standard.setValue(homeModel.sumRevenue, forKey: SumRevenue)
                UserDefaults.standard.setValue(homeModel.unreadMessageCount, forKey: UnreadMessageCount)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: homeModel), forKey: MyHomeModel)
                if getDataSuccess == false {
                    getDataSuccess = true
                } else {
                    self.initCellDataWithHomeModel(homeModel: homeModel)
                    self.homeHeaderView?.refresh()
                    self.tableView?.reloadData()
                }
            }
        }
        GetBannerList { (response, data, error) in
            if getDataSuccess == false {
                getDataSuccess = true
            } else {
                self.initCellDataWithHomeModel(homeModel: self.homeModel)
                self.homeHeaderView?.refresh()
                self.tableView?.reloadData()
            }
        }
    }
    
    /**
     *  初始化数据
     *
     *  @param data 首页数据模型
     *
     *  @return 初始化数据是否成功
     */
    fileprivate func initCellDataWithHomeModel(homeModel: HomeModel?) {

        if homeModel == nil {
            return
        }
        
        self.cellData.removeAll()
        var dic1: Dictionary<String, Any> = ["title" : "",
                "titleDetail" : "",
                "class" : HomeDivisionCell.classForCoder(),
                "value" : "",
                "height" : HomeDivisionCellHeight,
                "sel" : "goToTaskDivision"]
        if !homeModel!.isShowXsModel && homeModel!.productList.count > 0 {
            dic1 = ["title" : "精选理财",
                "titleDetail" : "更多",
                "class" : ProductListCell.classForCoder(),
                "value" : homeModel!.productList,
                "height" : ProductListCellHeight,
                "sel" : "goToProductDetail:"]
        }
        
        let dic2: Dictionary<String, Any> = ["title" : "互助保障",
            "titleDetail" : "更多",
            "class" : CooperationCell.classForCoder(),
            "value" : homeModel!.productHzList.count > 0 ? homeModel!.productHzList : "",
            "height" : CooperationCellHeight,
            "sel" : "goToCooperationDetail:"]

        var dic3: Dictionary<String, Any>? = self.getBannerDictonary()
        if dic3 == nil || dic3!.count == 0 {
            dic3 = ["title" : "热门活动",
                    "titleDetail" : "更多",
                    "class" : HomeBannerCell.classForCoder(),
                    "value" : Array<HomeBannerCell>(),
                    "height" : BannerCellHeight,
                    "sel" : ""]
        }
        
        let dic4: Dictionary<String, Any> = ["title" : "众筹计划",
            "titleDetail" : homeModel!.productZcList.count > 0 ? "更多" : "",
            "class" : CrowdfundingCell.classForCoder(),
            "value" : homeModel!.productZcList.count > 0 ? homeModel!.productZcList : "",
            "height" : CrowdfundingCellHeight,
            "sel" : "goToCrowdfundingDetail:"]
        
        let dic5: Dictionary<String, Any> = ["title" : "借款申请",
            "titleDetail" : "详情",
            "class" : HomeLoanCell.classForCoder(),
            "value" : "",
            "height" : HomeLoanCellHeight,
            "sel" : "goToLoan"]
        
        self.cellData = [dic1, dic3!, dic2, dic4, dic5]
    }
    
    fileprivate func getBannerDictonary() -> Dictionary<String, Any>? {
        var dic: Dictionary<String, Any>?
        if let data = UserDefaults.standard.value(forKey: BannerHomeAndBannerIntroduction) as? Data {
            if let bannerList: Array<BannerModel> = NSKeyedUnarchiver.unarchiveObject(with: data) as? Array<BannerModel> {
                if bannerList.count > 0 {
                    dic = ["title" : "热门活动",
                        "titleDetail" : "更多",
                        "class" : HomeBannerCell.classForCoder(),
                        "value" : bannerList,
                        "height" : BannerCellHeight,
                        "sel" : ""]
                }
            }
        }
        return dic
    }
    
    fileprivate func setTableView() {
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tableView!.backgroundColor = UIColor.white
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.autoresizingMask = UIViewAutoresizing.flexibleHeight
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.none
        homeHeaderView = HomeHeaderView.getHomeHeaderViewWithDelegate(delegate: self)
        tableView!.tableHeaderView = homeHeaderView
        self.view.addSubview(tableView!)
    }
    
    fileprivate func registerCell() {
        tableView!.register(ProductListCell.classForCoder(), forCellReuseIdentifier: ProductListCellIdentify)
        tableView!.register(HomeLoanCell.classForCoder(), forCellReuseIdentifier: HomeLoanCellIdentify)
        tableView!.register(HomeDivisionCell.classForCoder(), forCellReuseIdentifier: HomeDivisionCellIdentify)
        tableView!.register(CooperationCell.classForCoder(), forCellReuseIdentifier: CooperationCellIdentify)
        tableView!.register(CrowdfundingCell.classForCoder(), forCellReuseIdentifier: CrowdfundingCellIdentify)
        tableView!.register(HomeBannerCell.classForCoder(), forCellReuseIdentifier: HomeBannerCellIdentify)
    }
    
    // MARK: - table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cellData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var dataDictionary: Dictionary<String, Any> = self.cellData[section]
        let cellClass: AnyClass = dataDictionary["class"] as! AnyClass
        let value = dataDictionary["value"]
        if cellClass == HomeBannerCell.classForCoder() {
            return 1
        } else {
            if let datas = value as? Array<Any> {
                return datas.count
            } else {
                return 1;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataDictionary = self.cellData[indexPath.section]
        let cellClass: AnyClass = dataDictionary["class"] as! AnyClass
        if cellClass == HomeDivisionCell.classForCoder() {
            return self.getDivisionCellWithIndexPath(indexPath)
        } else if cellClass == BaseProductListCell.classForCoder() {
            return self.getProductListCellWithIndexPath(indexPath)
        } else if cellClass == CooperationCell.classForCoder() {
            return self.getCooperationCelllWithIndexPath(indexPath)
        } else if cellClass == HomeBannerCell.classForCoder() {
            return self.getBannerCellWithIndexPath(indexPath)
        } else if cellClass == CrowdfundingCell.classForCoder() {
            return self.getCrowdfundingCelllWithIndexPath(indexPath)
        } else if cellClass == HomeLoanCell.classForCoder() {
            return self.getHomeLoanCelllWithIndexPath(indexPath)
        } else {
            return self.getDivisionCellWithIndexPath(indexPath)
        }
    }
    
    // MARK: - table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.cellData[indexPath.section]["height"] as! CGFloat
        return height
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return DefaultSectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dataDictionary = self.cellData[section]
        let cellClass: AnyClass = dataDictionary["class"] as! AnyClass
        if cellClass == HomeDivisionCell.classForCoder() {
            return DefaultSectionHeight
        }
        return SectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dataDictionary = self.cellData[section]
        let cellClass: AnyClass = dataDictionary["class"] as! AnyClass
        if cellClass == HomeDivisionCell.classForCoder() {
            let headerView = UIView.init(frame: CGRect.zero)
            headerView.backgroundColor = UIColor.white
            return headerView
        } else {
            let homeSectionHeader = HomeSectionHeaderView.getHomeSectionHeaderView(title: self.cellData[section]["title"] as! String, titleDetail: self.cellData[section]["titleDetail"] as! String?)
            homeSectionHeader.delegate = self
            homeSectionHeader.classString = NSStringFromClass(cellClass)
            return homeSectionHeader
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - 获取不同cell
    fileprivate func getDivisionCellWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeDivisionCell(style: UITableViewCellStyle.default, reuseIdentifier: HomeDivisionCellIdentify)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    fileprivate func getProductListCellWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductListCell(style: UITableViewCellStyle.default, reuseIdentifier: ProductListCellIdentify)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let productList: Array<ProductModel> = self.cellData[indexPath.section]["value"] as! Array<ProductModel>
        cell.product = productList[indexPath.row]
        cell.progressView.isHidden = true
        return cell
    }
    
    fileprivate func getCooperationCelllWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = CooperationCell(style: UITableViewCellStyle.default, reuseIdentifier: CooperationCellIdentify)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let value = self.cellData[indexPath.section]["value"]
        if  let data = value as? Array<CooperationModel> {
            cell.data = data[indexPath.row]
        } else {
            cell.data = value!
        }
        cell.hideJoin = true
        return cell
    }
    
    fileprivate func getBannerCellWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeBannerCell(style: UITableViewCellStyle.default, reuseIdentifier: HomeBannerCellIdentify)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.delegate = self
        cell.data = self.cellData[indexPath.section]["value"] as! Array<BannerModel>
        return cell
    }
    
    fileprivate func getCrowdfundingCelllWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = CrowdfundingCell(style: UITableViewCellStyle.default, reuseIdentifier: CrowdfundingCellIdentify)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let value = self.cellData[indexPath.section]["value"]
        if  let data = value as? Array<CrowdfundingModel> {
            cell.data = data[indexPath.row]
        } else {
            cell.data = value!
        }
        return cell
    }
    
    fileprivate func getHomeLoanCelllWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeLoanCell(style: UITableViewCellStyle.default, reuseIdentifier: HomeLoanCellIdentify)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}
