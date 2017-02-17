//
//  HomeRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class HomeRootController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.loadData()
        self.setTableView()
        self.registerCell()
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
        tableView!.backgroundColor = BackgroundColor
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView!)
    }
    
    func registerCell() {
//        tableView!.register(ProductListCell.classForCoder(), forCellReuseIdentifier: "ProductListCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductListCell(style: UITableViewCellStyle.default, reuseIdentifier: "ProductListCell")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        cell.product = sourceData[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
}
