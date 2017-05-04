//
//  BaseTableViewController.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 2017/5/3.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var currentPage = 0
    var pageSize = 10
    var totalCount = 0
    lazy var tableView: UITableView = {
        var tableView = UITableView.init()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTableView(style: UITableViewStyle.plain)
    }
    
    func createTableView(frame: CGRect, style: UITableViewStyle) {
        self.tableView.removeFromSuperview()
        self.tableView = UITableView.init(frame: frame, style: style)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    func createTableView(style: UITableViewStyle) {
        self.tableView.removeFromSuperview()
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - (self.tabBarController?.tabBar.height)! - (self.navigationController?.navigationBar.height)!), style: style)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}
