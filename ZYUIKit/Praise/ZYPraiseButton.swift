//
//  ZYPraiseButton.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ZYPraiseButton: UIButton {

    var emitterLayer:CAEmitterLayer?
    var emitterCell:CAEmitterCell?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configPraiseBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 配置粒子
    func configPraiseBtn() -> Void {
        
        self.emitterCell = CAEmitterCell.init()
        self.emitterCell?.name = "emitter"
        self.emitterCell?.alphaSpeed = -1.0
        self.emitterCell?.alphaSpeed = 0.1
        self.emitterCell?.lifetime = 1.0
        self.emitterCell?.lifetimeRange = 0.1
        self.emitterCell?.velocity = 40
        self.emitterCell?.velocityRange = 10
        self.emitterCell?.scale = 0.5
        self.emitterCell?.scaleRange = 0.1
        self.emitterCell?.contents = #imageLiteral(resourceName: "spark_red").cgImage
        
        self.emitterLayer = CAEmitterLayer.init()
        self.layer.addSublayer(self.emitterLayer!)
        self.emitterLayer?.emitterSize = CGSize.init(width: self.bounds.size.width+40, height: self.bounds.size.height+40)
        self.emitterLayer?.renderMode = kCAEmitterLayerOldestFirst
        self.emitterLayer?.emitterMode = kCAEmitterLayerOutline
        self.emitterLayer?.emitterShape = kCAEmitterLayerCircle
        
        self.emitterLayer?.position = CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        self.emitterLayer?.emitterCells = [self.emitterCell!]
        
        self.emitterLayer?.setValue(NSNumber.init(value: 2000), forKey: "emitterCells.explosionCell.birthRate")
        
        self.emitterLayer?.beginTime = CACurrentMediaTime()
    }
    
    // MARK: - 设置发射源
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.emitterLayer?.backgroundColor = UIColor.red.cgColor
        
        // 发射源位置
        self.emitterLayer?.position = CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    
    //MARK:-isSelected
    override var isSelected: Bool{
        
        didSet{
            
            if isSelected == true {
                self.startAnimation()
            }else{
                self.stopAnimation()
            }
        }
    }
    
    // MARK: - 移除高亮
    override var isHighlighted: Bool{
        
        get{
            
            return false
        }
        
        set{
            
        }
    }
    
    // MARK: - 开始动画
    func startAnimation() -> Void {
        
        let scaleAnimation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        scaleAnimation.values = [1.2, 0.8, 1.8, 1.0]
        scaleAnimation.duration = 1.0
        scaleAnimation.repeatCount = 1
        self.layer.add(scaleAnimation, forKey: "scaleAnimation")
        
        self.emitterLayer?.setValue(NSNumber.init(value: 2000), forKey: "emitterCells.emitterCell.birthRate")
        
        //开始粒子动画
        self.emitterLayer?.beginTime = CACurrentMediaTime()
    }
    
    // MARK: - 结束动画
    func stopAnimation() -> Void {
        
        self.layer.removeAllAnimations()
    }
}
