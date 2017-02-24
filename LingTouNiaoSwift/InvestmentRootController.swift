//
//  InvestmentRootController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/3.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class InvestmentRootController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let pageSize = 10
    var currentPage = 0
    var tableView: UITableView?
    var sourceData = Array<ProductModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "理财"
        
        self.loadData()
        self.setTableView()
        self.registerCell()
    }
    
    func registerCell() {
        tableView!.register(ProductListCell.classForCoder(), forCellReuseIdentifier: "ProductListCell")
    }
    
    func loadData() {
        let params = ["pageSize": pageSize, "currentPage": currentPage]
        ProductListModel.getProductList(params: params) { (response, productList, error) in
            if productList != nil {
                let productList = productList as! ProductListModel
                self.sourceData = productList.productList!
                self.tableView?.reloadData()
            }
        }
    }
    
    func loadMoreData() {
        
    }

    func setTableView() {
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.grouped)
        tableView!.backgroundColor = BackgroundColor
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductListCell(style: UITableViewCellStyle.default, reuseIdentifier: "ProductListCell")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.product = sourceData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProductListCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
