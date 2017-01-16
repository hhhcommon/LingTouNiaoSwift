//
//  UIBarButtonItem+ClearBackground.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

import UIKit

// bar button
extension UIBarButtonItem {
    
    class func createBarItem(image: UIImage, target: Any?, action: Selector) -> UIBarButtonItem {
        return self.createBarItem(image: image, highlightImage: nil, target: target, action: action)
    }

    class func createBarItem(image: UIImage, highlightImage: UIImage?, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        button.setImage(image, for: UIControlState.normal)
        if highlightImage != nil {
            button.setImage(image, for: UIControlState.highlighted)
        }
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem.init(customView: button);
        return barButton;
    }
    
    class func createBarItem(title: String, target: Any?, action: Selector) -> UIBarButtonItem {
        return self.createBarItem(title: title, style: UIBarButtonItemStyle.plain, target: target, action: action)
    }
    
    class func createBarItem(title: String, target: Any?, action: Selector, color: UIColor?) -> UIBarButtonItem {
        return self.createBarItem(title: title, style: UIBarButtonItemStyle.plain, target: target, action: action, color: color)
    }
    
    class func createBarItem(title: String, style: UIBarButtonItemStyle, target: Any?, action: Selector, color: UIColor?) -> UIBarButtonItem {
        return self.createBarItem(title: title, image: nil, highlightImage: nil, style: style, target: target, action: action, color: color)
    }
    
    func createBarItem(title: String, image: UIImage, highlightImage: UIImage, style: UIBarButtonItemStyle, target: Any?, action: Selector, color: UIColor?) -> UIBarButtonItem {
        let button = UIButton.init(type: UIButtonType.custom)
        
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 32)
        button.setImage(image, for: UIControlState.normal)
        button.setImage(highlightImage, for: UIControlState.highlighted)
        
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 32)
        button.setTitle(title, for: UIControlState.normal)
        if color != nil {
            button.setTitleColor(color, for: UIControlState.normal)
            button.setTitleColor(color?.withAlphaComponent(0.3), for: UIControlState.highlighted)
        } else {
            button.setTitleColor(NavigationTintColor, for: UIControlState.normal)
        }
        
        button.titleLabel?.font = CustomerizedFont.boldSystemFontOfSize(fontSize: 16.0)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.sizeToFit()
        
        let barButton = UIBarButtonItem.init(customView: button)
        return barButton;
    }
    
    class func createBarItem(title: String, style: UIBarButtonItemStyle, target: Any?, action: Selector) -> UIBarButtonItem {
        return self.createBarItem(title: title, image: nil, highlightImage: nil, style: style, target: target, action: action)
    }

    class func createBarItem(title: String, image: UIImage?, highlightImage: UIImage?, style: UIBarButtonItemStyle, target: Any?, action: Selector, color: UIColor?) -> UIBarButtonItem {
        let button = UIButton.init(type: UIButtonType.custom)
        let width: CGFloat = 40
        button.frame = CGRect(x: 0, y: 0, width: width, height: 32)
        
        button.setImage(image, for: UIControlState.normal)
        button.setImage(highlightImage, for: UIControlState.highlighted)
        button.setTitle(title, for: UIControlState.normal)
        if color != nil {
            button.setTitleColor(color, for: UIControlState.normal)
            button .setTitleColor(color?.withAlphaComponent(0.3), for: UIControlState.highlighted)
        } else {
            button.setTitleColor(NavigationTintColor, for: UIControlState.normal)
        }
        
        button.titleLabel?.font = CustomerizedFont.systemFontOfSize(fontSize: 16)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        let barButton = UIBarButtonItem.init(customView: button)
        return barButton;
    }
    
    class func createBarItem(title: String, image: UIImage?, highlightImage: UIImage?, style: UIBarButtonItemStyle, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 32)
        button.setImage(image, for: UIControlState.normal)
        button.setImage(highlightImage, for: UIControlState.highlighted)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        if Double(UIDevice.current.systemVersion)! < 7 {
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
        
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(NavigationTintColor, for: UIControlState.normal)
        button.titleLabel?.font = CustomerizedFont.systemFontOfSize(fontSize: 16)
        button.titleLabel?.textAlignment = NSTextAlignment.center;
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.sizeToFit()
        
        let barButton = UIBarButtonItem.init(customView: button)
        return barButton;
    }

    class func createBarItem(title: String, image: UIImage, highlightImage: UIImage, style: UIBarButtonItemStyle, target: Any?, action: Selector, space: CGFloat) -> UIBarButtonItem {
        
        let buttonView = UIView()
        let imageView = UIImageView.init(image: image)
        
        let label = UILabel()
        label.font = CustomerizedFont.systemFontOfSize(fontSize: 16)
        label.textColor = UIColor.black
        label.text = title;
        label.sizeToFit()
        
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        
        var newSpace = space
        if (imageView.width <= 1 || label.width <= 1) {
            newSpace = 0
        }
        buttonView.size = CGSize(width: 10 + imageView.width + space + label.width, height: min(SystemNavigationHeight, max(imageView.height, label.height)))
        imageView.centerY = buttonView.myCenterY()
        label.centerY = buttonView.myCenterY()
        imageView.left = 10
        label.left = imageView.right + newSpace
        
        buttonView.addGestureRecognizer(UIGestureRecognizer.init(target: target, action: action))
        
        let barButton = UIBarButtonItem.init(customView: buttonView)
        return barButton
    }
    
//    + (UIBarButtonItem *)closeBarItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
//    {
//    UIBarButtonItem *barItem = [self barItemWithTitle:title target:target action:action];
//    
//    UIButton *button = (UIButton *)barItem.customView;
//    
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    
//    return barItem;
//    }
//    
//    + (UIBarButtonItem*)backBarItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
//    {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    NSDictionary *ats = @{
//    NSFontAttributeName : [CustomerizedFont boldSystemFontOfSize:14],
//    };
//    CGSize stringsize = [title sizeWithAttributes:ats];
//    button.frame = CGRectMake(0, 0, 28+stringsize.width, 40);
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
//    UIImage *normalBG = [UIImage imageNamed:@"btn_nav_back"];
//    normalBG = [normalBG stretchableImageWithLeftCapWidth:16 topCapHeight:8];
//    UIImage *downBG = [UIImage imageNamed:@"btn_nav_back_down"];
//    downBG = [downBG stretchableImageWithLeftCapWidth:16 topCapHeight:8];
//    [button setBackgroundImage:normalBG forState:UIControlStateNormal];
//    [button setBackgroundImage:downBG forState:UIControlStateHighlighted];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [CustomerizedFont boldSystemFontOfSize:14.0f];
//    button.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
//    button.titleLabel.layer.shadowOffset = CGSizeMake(0, 1);
//    button.titleLabel.layer.shadowOpacity = 0.3f;
//    button.titleLabel.layer.shadowRadius = 0;
//    button.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    return barButton;
//    }
}
