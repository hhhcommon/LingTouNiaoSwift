//
//  BarProgressView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/15.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

class BarProgressView: UIView {

    var progress: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var progressColor: UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var groundColor: UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        self.progress = 0
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        let width = rect.size.width
        let height = rect.size.height
        UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.5).addClip()
        context?.setLineCap(CGLineCap.round)
        
        // 底部bar
        
        if groundColor == nil {
            groundColor = UIColor.colorWithRGB(236, 236, 236)
        }
        groundColor!.set()
        context?.setLineWidth(height)
        context?.move(to: CGPoint(x: 0, y: height * 0.5))
        context?.addLine(to: CGPoint(x: width, y: height * 0.5))
        context?.strokePath()
        
        // 进度bar
        if progressColor == nil {
            progressColor = UIColor.colorWithRGB(253, 182, 10)
        }
        let to = progress * width
        context?.move(to: CGPoint(x: 0, y: height * 0.5))
        context?.addLine(to: CGPoint(x: to, y: height * 0.5))
        context?.strokePath()
        
        context?.restoreGState()
    }
}
