//
//  CustomTextField.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    let leftLabel = UILabel()
    var limitedCount = 0 {
        willSet {
            if newValue > 0 {
                NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldTextDidChange(textField:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
            }
        }
    }
    var drawLeftLine = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var drawRightLine = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var drawTopLine = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var drawBottomLine = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var lineWidth = LineThick {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var lineColor = LineColor {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var placeholder: String? {
        willSet {
            attributedPlaceholder = NSAttributedString(string: newValue!, attributes: [NSForegroundColorAttributeName : ColorECECEC, NSFontAttributeName : normalFont(16)])
        }
    }

    // init methods
    convenience init(frame: CGRect, leftTitle: String, placeholder: String) {
        self.init(frame: frame)
        self.placeholder = placeholder
        leftLabel.text = leftTitle
        self.leftView = leftLabel
        self.leftViewMode = UITextFieldViewMode.always
    }
    
     convenience init(frame: CGRect, leftIconName: String, placeholder: String) {
        self.init(frame: frame)
        self.placeholder = placeholder
        let leftImageView = UIImageView(image: UIImage(named: leftIconName))
        leftImageView.contentMode = UIViewContentMode.center
        self.leftView = leftImageView
        self.leftViewMode = UITextFieldViewMode.always
        
    }

    convenience init(leftTitle: String, placeholder: String) {
        self.init(frame: CGRect.zero, leftTitle: leftTitle, placeholder: placeholder)
    }

    convenience init(leftIconName: String, placeholder: String) {
        self.init(frame: CGRect.zero, leftIconName: leftIconName, placeholder: placeholder)
    }
    
    // override
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = Color333333
        font = normalFont(14)
        clearButtonMode = UITextFieldViewMode.whileEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.leftViewRect(forBounds: bounds)
        if leftView is UILabel {
            frame.origin.x += CommonMargin
            frame.size.width = 88
        } else if leftView is UIImageView {
            frame.size.width = 44
        }
        frame.size.height = bounds.size.height
        frame.origin.y = 0
        return frame
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.textRect(forBounds: bounds)
        if leftView is UIImageView {
            frame.origin.x += 5
        }
        return frame
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.editingRect(forBounds: bounds)
        if leftView is UIImageView {
            frame.origin.x += 5
        }
        return frame
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(lineColor.cgColor)
        if drawBottomLine {
            context?.fill(CGRect(x: 0, y: frame.height - lineWidth, width: frame.width, height: lineWidth))
        }
        if drawTopLine {
            context?.fill(CGRect(x: 0, y: 0, width: frame.width, height: lineWidth))
        }
        if drawLeftLine {
            context?.fill(CGRect(x: 0, y: 0, width: lineWidth, height: frame.height))
        }
        if drawRightLine {
            context?.fill(CGRect(x: frame.width - lineWidth, y: 0, width: lineWidth, height: frame.height))
        }
    }
    
    // notification methods
    func textFieldTextDidChange(textField: UITextField) {
        if (text?.characters.count)! > limitedCount {
            let finalText = text?.substring(to: (text?.index((text?.startIndex)!, offsetBy: limitedCount))!)
            text = finalText
        }
    }
    
    // dealloc
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
