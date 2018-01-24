//
//  ScratchcardView.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/24.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ScratchcardView: UIView {

    var ScratchcardView:UIView?
    var contentsLab:UILabel?
    var coverImageView:UIImageView?
    
    typealias clickClosure = () ->(Void)
    var click:clickClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scratchView()
    }

    
    func scratchView() -> Void {
        
        contentsLab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        contentsLab?.numberOfLines = 0
        contentsLab?.isUserInteractionEnabled = true
        contentsLab?.lineBreakMode = .byCharWrapping
        self.addSubview(contentsLab!)
        
        let ges:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(touchClick))
        contentsLab?.addGestureRecognizer(ges)
        
        let coverImageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: (contentsLab?.frame.size.width)!, height: (contentsLab?.frame.size.height)!))
        coverImageView.isUserInteractionEnabled = true
        self.addSubview(coverImageView)
        
        self.coverImageView = coverImageView
    }
    
    @objc func touchClick() -> Void {
        
        self.click!()

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        let touch:UITouch = touches.first!
        
        let point:CGPoint = touch.location(in: self.coverImageView)
        
        //设置清除范围
        let clearRect:CGRect = CGRect.init(x: point.x, y: point.y, width: 40, height: 40)
        
        //与imgView同大小的上下文
    UIGraphicsBeginImageContextWithOptions((self.coverImageView?.bounds.size)!, false, 0.0)
        
        //获取上下文
        let context:CGContext? = UIGraphicsGetCurrentContext()
        
        //将上下文添加到imgView的layer层
        self.coverImageView?.layer.render(in: context!)
        
        //清除上下文中需要清理的rect
        context!.clear(clearRect)
        
        //获取之后的图片
        let finalImageV:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        self.coverImageView?.image = finalImageV!
    }
    
    // 设置第一响应始终为中奖文字
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let activeView = super.hitTest(point, with: event)
        
        if activeView != contentsLab {
            return contentsLab
        }
        
        return activeView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
