//
//  ZYProgressView.swift
//  ZYProgressLabel
//
//  Created by macOfEthan on 2018/1/23.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ZYProgressView: UIView {

    var backgroundLab:UILabel?
    var foregroundLab:UILabel?
    var foreMaskView:UIView?
    
    var foreViewWidth:CGFloat = 0.0
    var progress:CGFloat = 0.3

    //是否来回
    var forward:Bool = true
    
    var displayLink:CADisplayLink{
        
        set{
            
        }
        get{
            
            let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(progressChanged(_:)))
            displayLink.add(to: .main, forMode: .commonModes)
            
            return displayLink
        }

    }
    
    // 底部label文字颜色
    var backgroundLabTextColor:UIColor?{
        
        didSet{
            
            self.backgroundLab?.textColor = backgroundLabTextColor
        }
    }
    
    // 顶部label文字颜色
    var foregroundLabTextColor:UIColor?{
        
        didSet{
            
            self.foregroundLab?.textColor = foregroundLabTextColor
        }
    }
    
    // 顶部背景颜色
    var foreMaskViewBgColor:UIColor?{
        
        didSet{
            
            self.foreMaskView?.backgroundColor = foreMaskViewBgColor
        }
    }
    
    // 文字
    var text:String?{
        
        didSet{
            
            self.backgroundLab?.textAlignment = .left
            self.foregroundLab?.textAlignment = .left
            
            // 设置换行 移除...
            self.backgroundLab?.lineBreakMode = .byCharWrapping
            self.foregroundLab?.lineBreakMode = .byCharWrapping
            
            self.backgroundLab?.text = text
            self.foregroundLab?.text = text
        }
    }
    
    // 速度
    var speed:CGFloat?{
        
        didSet{
            
            self.progress = speed!
        }
    }
    
    //是否来回
    var backforwards:Bool?
    
    // MARK: - 改变进度
    @objc func progressChanged(_ displayLink:CADisplayLink) -> Void {
        
        if self.backforwards! {
            
            if self.forward {
                
                self.foreViewWidth += self.progress
                if self.foreViewWidth >= self.bounds.size.width {
                    
                    self.forward = false
                }
            }else{
                self.foreViewWidth -= self.progress
                if self.foreViewWidth <= 0{
                    
                    self.forward = true
                }
            }
            
        }else{
        
            if self.foreViewWidth >= self.bounds.size.width {

                self.foreViewWidth = 0
                
            }
            
            self.foreViewWidth += self.progress
        }
        
        self.foreMaskView?.frame = CGRect.init(x: 0, y: 0, width: self.foreViewWidth, height: self.bounds.size.height)
        self.foregroundLab?.frame = CGRect.init(x: 0, y: 0, width: self.foreViewWidth, height: self.bounds.size.height)
        
    }
    
    override init(frame: CGRect) {
      
        super.init(frame: frame)
        
        self.foregroundLabTextColor = UIColor.red
        self.backgroundLabTextColor = UIColor.black
        self.foreMaskViewBgColor = UIColor.green
        self.foreViewWidth = 0
        
        self.progressViewInit()
        
        displayLink.isPaused = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func progressViewInit() -> Void {
        
        backgroundLab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.addSubview(backgroundLab!)
        
        foreMaskView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.foreViewWidth, height: self.bounds.size.height))
        foreMaskView?.backgroundColor = UIColor.clear
        self.addSubview(foreMaskView!)
        
        foregroundLab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.foreViewWidth, height: self.bounds.size.height))
        foreMaskView!.addSubview(foregroundLab!)
    }
    
    deinit {
        
        self.foregroundLab?.removeFromSuperview()
        self.foreMaskView?.removeFromSuperview()
        self.backgroundLab?.removeFromSuperview()
        self.displayLink.invalidate()
    }
    
}




