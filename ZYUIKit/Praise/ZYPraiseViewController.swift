//
//  ZYPraiseViewController.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ZYPraiseViewController: ZYViewController {

    var praiseBtn:ZYPraiseButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (self.navigationController as! ZYNavgationController).panGesDisEnabled = false
        
        self.navigationItem.title = "点赞效果"
        
        self.praiseBtn = ZYPraiseButton(frame: CGRect.init(x: 100, y: 100, width: 30, height: 30))
        self.praiseBtn?.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
        self.praiseBtn?.setImage(#imageLiteral(resourceName: "liek_orange"), for: .selected)
        self.praiseBtn?.addTarget(self, action: #selector(self.btnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(self.praiseBtn!)
        
        self.snow()
    }
    
    func snow() -> Void {
        
        let snowLayer:CAEmitterLayer = CAEmitterLayer.init()
        snowLayer.frame = self.view.bounds
        self.view.layer.addSublayer(snowLayer)
        //rederMode：控制着在视觉上粒子图片是如何混合的。我们在实例中设置为了KCAEmitterLayerAdditive，它表示这：合并粒子重叠部分的亮度使其更加明亮，其他效果可以尝试下。
        snowLayer.renderMode = kCAEmitterLayerAdditive
        //emitterPosition：表示粒子发射器的中心位置
        snowLayer.emitterPosition = CGPoint.init(x: snowLayer.frame.size.width/3, y: UIScreen.main.bounds.size.height/2)
        
        let snowCell:CAEmitterCell = CAEmitterCell.init()
        snowCell.contents = #imageLiteral(resourceName: "刮刮乐").cgImage
        snowCell.birthRate = 15.0
        snowCell.lifetime = 7.0
        snowCell.alphaSpeed = 0
        snowCell.velocity = 150
        snowCell.velocityRange = 100
        snowCell.emissionLatitude = CGFloat(M_PI_2)
        snowCell.emissionRange = CGFloat(M_PI_2)
        snowLayer.emitterCells = [snowCell]
    }
    
    
    func btnClicked(_ sender:UIButton) -> Void {
        
        sender.isSelected = !sender.isSelected
    }
}
