//
//  BannerView.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/2/24.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol BannerViewDelegate {
    @objc optional func clickBanner(bannerView: BannerView, banner: BannerModel)
}

private let Margin: CGFloat = 10
// 一张图占屏幕的比例
private let Ratio: CGFloat = 0.92
// 动画时间
let AnimationDuration: TimeInterval = 0.3

// 是否图完全靠紧左侧，具体需要根据kContentOffset的值来设置
let TightToLeft = true

class BannerView: UIView, UIScrollViewDelegate {
    
    var delegate: BannerViewDelegate?
    
    // 偏移量：默认kRatio * self.width为整张图，包含左右间距
    //#define kContentOffset (kRatio * self.width - (1 - kRatio) * self.width * 0.5)
    var ContentOffset: CGFloat {
        get {
            return Ratio * self.width + Margin * 0.5
        }
    }
    
    var BannerWidth: CGFloat {
        get {
            return self.width * Ratio - Margin
        }
    }
    
    var BannerHeight: CGFloat {
        get {
            return self.height
        }
    }
    
    var bannersList: Array<BannerModel> {
        didSet {
            timer?.invalidate()
            self.setupUI()
        }
    }
    let scroll = UIScrollView()
    let page = UIPageControl()
    var timer: Timer?
    lazy var swipeLeft: UISwipeGestureRecognizer = {
        let swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(carousel(_:)))
        swipeLeft.direction = .left
        return swipeLeft
    }()
    
    lazy var swipeRight: UISwipeGestureRecognizer = {
        let swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(carousel(_:)))
        swipeLeft.direction = .right
        return swipeLeft
    }()
    
    var isSwiping = false
    var isSubPage = false
    
    override init(frame: CGRect) {
        bannersList = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 搭建页面
    fileprivate func setupUI() {
        if self.subviews.count > 0 {
            for view in self.subviews {
                view.removeFromSuperview()
            }
            return
        }
        
        // 创建scrollView
        scroll.frame = self.bounds
        scroll.isScrollEnabled = false
        self.addSubview(self.scroll)
        
        // 设置滚动图片，图片顺序：3-[0-1-2-3]-0
        let count = self.bannersList.count
        if count <= 1 {
            let banner = bannersList.first
            let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: BannerWidth, height: BannerHeight))
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.centerX = ScreenWidth * 0.5
            let url = URL(string: banner!.bannerPicture)
            imageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "placeholder_banner"), options: SDWebImageOptions.retryFailed)
            self.addTapForImageView(imageView)
            scroll.addSubview(imageView)
            return
        }
        
        for i in 0..<count+2 {
            
            let x: CGFloat = (CGFloat(i) + 0.5) * Margin + CGFloat(i) * BannerWidth;
            let y: CGFloat = 0
            let imageView = UIImageView.init(frame: CGRect(x: x, y: y, width: BannerWidth, height: BannerHeight))
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            var banner: BannerModel?
            if (i == 0) {
                banner = bannersList[count - 1]
                imageView.tag = count - 1
            } else if (i == count + 1) {
                banner = bannersList[0]
                imageView.tag = 0
            } else {
                banner = bannersList[i - 1]
                imageView.tag = i - 1
            }
            let url = URL.init(string: banner!.bannerPicture)
            imageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "placeholder_banner"), options: SDWebImageOptions.retryFailed)
            self.addTapForImageView(imageView)
            scroll.addSubview(imageView)
        }
        
        // 设置属性及代理
        scroll.delegate = self
        let contentOffset = CGPoint(x: ContentOffset, y: 0)
        scroll.contentOffset = contentOffset
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        //    self.scroll.pagingEnabled = YES;
        
        // 设置滚动范围
        scroll.contentSize = CGSize(width: self.width * Ratio * CGFloat(bannersList.count + 2), height: BannerHeight)
        
        // 创建pageControl
        page.frame = CGRect(x: 0, y: self.height - 20, width: self.width, height: 20)
        page.numberOfPages = self.bannersList.count
        page.currentPageIndicatorTintColor = MainColor
        self.addSubview(page)
        page.isHidden = true
        
        // 创建定时器，定时滚动图片
        self.startTimer()
        
        // 添加轻扫手势及定时器
        self.addSwipeAndTimer()
    }
    
    func addSwipeAndTimer() {
        if isSwiping {
            isSwiping = false
            self.startTimer()
        }
        self.addGestureRecognizer(swipeLeft)
        self.addGestureRecognizer(swipeRight)
    }
    
    @objc fileprivate func carousel(_ swipe: UISwipeGestureRecognizer) {
        isSwiping = true
        timer?.invalidate()
        self.removeGestureRecognizer(swipeLeft)
        self.removeGestureRecognizer(swipeRight)
        self.autoScroll(obj: swipe)
    }
    
    fileprivate func addTapForImageView(_ imageView: UIImageView) {
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
        imageView.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func tap(recognizer: UIGestureRecognizer) {
        if bannersList.count == 0 {
            return
        }
        let imageView = recognizer.view as! UIImageView
        self.delegate?.clickBanner!(bannerView: self, banner: bannersList[imageView.tag])
    }
    
    // MARK: - 创建定时器，定时滚动图片
    fileprivate func startTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll(obj:)), userInfo: nil, repeats: true)
    }
    
    // MARK: - 定时器方法
    @objc fileprivate func autoScroll(obj: Any) {
        
        // 获取当前的page，并加1
        var page = self.page.currentPage
        if let swipe = obj as? UISwipeGestureRecognizer {
            switch swipe.direction {
            case UISwipeGestureRecognizerDirection.left:
                page += 1
            case UISwipeGestureRecognizerDirection.right:
                page -= 1
                isSubPage = true
            default: break
            }
        } else {
            page += 1
        }
        
        /**
         *  图片编号：0- 1-2-3-4 -5
         *  图片顺序：3-[0-1-2-3]-0（图片页数）
         */
        // 如果页数为4，则超出正常页数，需要变为0
        if page < 0 {
            page = self.bannersList.count - 1
        } else if page >= self.bannersList.count {
            page = 0
        }
        self.page.currentPage = page
        // 更换图片
        self.turnPage()
    }
    
    // MARK: - 根据页数更换图片
    fileprivate func turnPage() {
        /**
         *  图片编号：0- 1-2-3-4 -5
         *  图片顺序：3-[0-1-2-3]-0
         */
        var contentOffset = scroll.contentOffset
        if isSubPage {
            isSubPage = false
            if self.page.currentPage == self.bannersList.count - 1 {
                // 如果是第1张图片，需要先动画滚动到第0张，动画结束后再不动画到第4张
                UIView.animate(withDuration: AnimationDuration * 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    contentOffset.x = 0
                    self.scroll.contentOffset = contentOffset
                }, completion: { (finished) in
                    self.scroll.setContentOffset(CGPoint(x: CGFloat(self.bannersList.count) * self.width * Ratio, y: 0), animated: false)
                    UIView.animate(withDuration: AnimationDuration * 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        contentOffset.x = CGFloat(self.bannersList.count - 1) * self.width * Ratio + self.ContentOffset
                        self.scroll.contentOffset = contentOffset
                    }, completion: { (finished) in
                        self.addSwipeAndTimer()
                    })
                })
                return
            } else if page.currentPage == 0 {
                UIView.animate(withDuration: AnimationDuration, animations: {
                    contentOffset.x = self.ContentOffset
                    self.scroll.contentOffset = contentOffset
                }, completion: { (finished) in
                    self.addSwipeAndTimer()
                })
                return
            }
        }
        
        if page.currentPage != 0 {
            UIView.animate(withDuration: AnimationDuration, animations: {
                contentOffset.x = self.ContentOffset + self.width * Ratio * CGFloat(self.page.currentPage)
                self.scroll.contentOffset = contentOffset
            }, completion: { (finished) in
                self.addSwipeAndTimer()
            })
        } else {
            // 如果是第4张图片，需要先动画滚动到第5张，动画结束后再不动画到第1张
            UIView.animate(withDuration: AnimationDuration * 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                contentOffset.x = self.scroll.contentSize.width - self.width
                self.scroll.contentOffset = contentOffset
            }, completion: { (finished) in
                
                self.scroll.setContentOffset(CGPoint(x: self.width * Ratio * 2 - self.width, y: 0), animated: false)
                UIView.animate(withDuration: AnimationDuration * 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    contentOffset.x = self.ContentOffset
                    self.scroll.contentOffset = contentOffset
                }, completion: { (finished) in
                    self.addSwipeAndTimer()
                })
            })
        }
    }

    // MARK: - 滚动代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //     NSLog(@"%.2f", scrollView.contentOffset.x);
        var page = 0
        if TightToLeft {
            page = Int(scroll.contentOffset.x / BannerWidth)
        } else {
            page = Int((scroll.contentOffset.x + ContentOffset) / BannerWidth)
        }
        
        page = (page == (self.bannersList.count + 1) ? 0 : page - 1)
        self.page.currentPage = page
    }
}
