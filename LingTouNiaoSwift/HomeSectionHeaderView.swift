//
//  HomeSectionHeaderView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

protocol HomeSectionHeaderViewDelegate {
    func showMore(sectionHeaderView: HomeSectionHeaderView)
}

private let Margin = adaptiveBaseIphone6(15)

class HomeSectionHeaderView: UIView {

    var delegate: HomeSectionHeaderViewDelegate?
    
    class func getHomeSectionHeaderView(title: String, titleDetail: String?) -> HomeSectionHeaderView {
        
        let homeSectionHeaderView = HomeSectionHeaderView.init(frame:CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), title: title, titleDetail: titleDetail)
        homeSectionHeaderView.backgroundColor = UIColor.white
        return homeSectionHeaderView
    }

    init(frame: CGRect, title: String, titleDetail: String?) {
        super.init(frame: frame)
        let titleLabel = UILabel()
        titleLabel.font = boldFont(20)
        titleLabel.textColor = Color666666
        titleLabel.text = title
        titleLabel.sizeToFit()
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margin);
            make.centerY.equalToSuperview()
        }
        
        
        if titleDetail != nil && !titleDetail!.isEmpty {
            
            let detailButton = DetailButton.creatDetailButton(title: titleDetail!, rightImage: UIImage.init(named: "icon_arrow1")!, handleBlock: { (button) in
                self.delegate?.showMore(sectionHeaderView: self)
            })
            self.addSubview(detailButton)
            
            detailButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-Margin);
                make.centerY.equalTo(titleLabel)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
