//
//  ZYPraiseButton.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ZYPraiseButton: UIButton {

    let emitterLayer:CAEmitterLayer = CAEmitterLayer.init()
    let emitterCell:CAEmitterCell = CAEmitterCell.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configPraiseBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 配置粒子
    func configPraiseBtn() -> Void {
        
        self.layer.addSublayer(emitterLayer)
        
        //rederMode：控制着在视觉上粒子图片是如何混合的。我们在实例中设置为了KCAEmitterLayerAdditive，它表示这：合并粒子重叠部分的亮度使其更加明亮，其他效果可以尝试下。
        //        snowLayer.renderMode = kCAEmitterLayerAdditive
        //emitterPosition：表示粒子发射器的中心位置
        emitterLayer.emitterPosition = CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        //设置发射源形状
        emitterLayer.emitterShape = kCAEmitterLayerCircle
        //设置发射源发射位置
        emitterLayer.emitterMode = kCAEmitterLayerOutline
        //设置粒子渲染
        emitterLayer.renderMode = kCAEmitterLayerOldestFirst
        //设置发射源形状的大小
        emitterLayer.emitterSize = CGSize.init(width: 40, height: 40)
        
        emitterCell.name = "emitterCell"
        emitterCell.contents = #imageLiteral(resourceName: "spark_red").cgImage
        //设置产生速率
        emitterCell.birthRate = 500.0
        //设置消失时间
        emitterCell.lifetime = 1.0
        emitterCell.alphaSpeed = 0.1
        //设置发射速度
        emitterCell.velocity = 40
        emitterCell.velocityRange = 10
        //设置粒子大小比例
        emitterCell.scale = 1.0;
        emitterCell.scaleRange = 0.5;
        //设置发散范围
        emitterCell.emissionLongitude = 0
        emitterCell.emissionRange = CGFloat.pi*2
        emitterLayer.emitterCells = [emitterCell]
        
        emitterLayer.beginTime = CFTimeInterval(MAXFLOAT)
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
        
        //重新设置产生粒子的数量
        self.emitterLayer.setValue(NSNumber.init(value: 200), forKeyPath: "emitterCells.emitterCell.birthRate")
        
        //开始粒子动画
        self.emitterLayer.beginTime = CACurrentMediaTime()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            
            self.stopAnimation()
        }
    }
    
    // MARK: - 结束动画
    func stopAnimation() -> Void {
        
        self.emitterLayer.setValue(NSNumber.init(value: 0), forKey: "emitterCells.emitterCell.birthRate")
        self.emitterLayer.beginTime = CFTimeInterval(MAXFLOAT)
        self.layer.removeAllAnimations()
    }
    
    deinit {
        self.emitterLayer.removeFromSuperlayer()
    }
}
