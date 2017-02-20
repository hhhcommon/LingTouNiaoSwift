//
//  ActionBar.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

@objc protocol AcitonBarDelegate {
    @objc optional func clickAcitonBar(actionBar: ActionBar, index: NSInteger)
}

class ActionBar: UIView {

    var delegate: AcitonBarDelegate?
    var showSeparator: Bool {
        get {
            return self.showSeparator
        }
        set {
            if (newValue) {
                let count = self.subviews.count;
                let itemWidth = self.bounds.size.width / CGFloat(count)
                let separatorTop: CGFloat = 11
                for i in 0..<count-1 {
                    let separatorView = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1), y: separatorTop, width: 1 / ScreenScale, height: self.bounds.size.height - 2 * separatorTop))
                    separatorView.backgroundColor = LineColor
                    self.addSubview(separatorView)
                }
            }
        }
    }
    
    func addActionItem(icon: String, selectedIcon: String?, title: String) {
    
        let item = ActionItem()
        item.setImage(UIImage.init(named: icon), for: UIControlState.normal)
        if selectedIcon != nil {
            item.setImage(UIImage.init(named: selectedIcon!), for: UIControlState.selected)
        }
        item.setTitle(title, for: UIControlState.normal)
        item.addTarget(self, action: #selector(clickItem(item:)), for: UIControlEvents.touchUpInside)
        self.addSubview(item)
        
        let count = self.subviews.count
        // 调整frame
        for i in 0..<count {
            let item = self.subviews[i]
            item.tag = i
            let width = self.bounds.size.width / CGFloat(count)
            let height = self.bounds.size.height
            item.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
        }
    }
    
    func clickItem(item: ActionItem) {
        self.delegate?.clickAcitonBar!(actionBar: self, index: item.tag)
    }
}
