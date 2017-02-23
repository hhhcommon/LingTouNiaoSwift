//
//  DetailButton.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/23.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

typealias HandleBlock = ((Any?) -> Void)

class DetailButton: UIButton {

    var handleBlock: HandleBlock?
    
    class func creatDetailButton(title: String, rightImage: UIImage, handleBlock: HandleBlock?) -> DetailButton {
        let detailButton = DetailButton.init(title:title, rightImage:rightImage, handleBlock:handleBlock)
        return detailButton
    }

    convenience init(title: String, rightImage: UIImage, handleBlock: HandleBlock?) {
        self.init()
        self.handleBlock = handleBlock
        let titleLabel = UILabel()
        titleLabel.font = normalFont(14)
        titleLabel.textColor = Color999999
        titleLabel.text = title
        titleLabel.sizeToFit()
        self.addSubview(titleLabel)
        
        let imageView = UIImageView.init(image: rightImage)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(imageView)
        

//        let height = max(titleLabel.height, rightImageViewHeight)
//        self.bounds = CGRectMake(0, 0, self.titleLabel.width + imageView.width, height);
//        self.titleLabel.centerY = imageView.centerY = height * 0.5;
        
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(clickButton(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(button)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.right.equalTo(imageView.snp.left)
        }
        
        let rightImageViewHeight = max(rightImage.size.width, rightImage.size.height)
        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: rightImageViewHeight, height: rightImageViewHeight))
            make.right.centerY.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right)
        }
        
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func clickButton(_ button: UIButton) {
        self.handleBlock?(self)
    }
}
