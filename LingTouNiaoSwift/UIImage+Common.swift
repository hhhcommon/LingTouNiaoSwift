//
//  UIImage+Common.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 生成带纯色的图片
    class func imageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    class func imageWithColor(color: UIColor) -> UIImage {
        return UIImage.imageWithColorAndSize(color: color, size: CGSize(width: 1, height: 1))
    }
    
    // 生成圆角图片
    class func createRoundedRectImage(imageName: String, size: CGSize, radius: CGFloat) -> UIImage {
        var image = UIImage(named: imageName)
        var newRadius = min(size.width, size.height)
        newRadius = min(newRadius, radius)
        image = image?.imageWithCornerRadius(radius: radius)
        return image!
        
    }
    func imageWithCornerRadius(radius: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius) as! CGPath)
        context?.clip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!;
    }
}
