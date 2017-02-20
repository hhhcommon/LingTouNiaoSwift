//
//  ActionItem.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class ActionItem: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.文字居中
        self.titleLabel?.textAlignment = NSTextAlignment.center
        // 2.文字大小
        self.titleLabel?.font = boldFont(12)
        // 3.图片的内容模式
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.setTitleColor(Color666666, for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 调整内部ImageView的frame
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageY = adaptiveBaseIphone6(14)
        let imageWidth = adaptiveBaseIphone6(40)
        let imageHeight = adaptiveBaseIphone6(40)
        
        return CGRect(x: self.width/2-imageWidth/2, y: imageY, width: imageWidth, height: imageHeight)
    }
    
    // MARK: - 调整内部UILabel的frame
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX: CGFloat = 0
        let titleHeight = contentRect.size.height * 0.2
        let titleY = contentRect.size.height - adaptiveBaseIphone6(8) - titleHeight
        let titleWidth = contentRect.size.width
        
        return CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight)
    }
}
