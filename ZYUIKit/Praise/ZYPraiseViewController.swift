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
    
    var red_paceketCell:CAEmitterCell = CAEmitterCell.init()
    let red_paceketLayer:CAEmitterLayer = CAEmitterLayer.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:-移除手势
        (self.navigationController as! ZYNavgationController).panGesDisEnabled = true
        
        self.praise()
      
        self.red_paceket()
        
        let alertLab:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 20))
        alertLab.text = "点击屏幕红包多多"
        alertLab.textAlignment = .center
        alertLab.textColor = UIColor.red
        self.view.addSubview(alertLab)
    }
    
    // MARK: - 点赞
    func praise() -> Void {
        
        self.navigationItem.title = "CAEmitterLayer效果"
        
        self.praiseBtn = ZYPraiseButton(frame: CGRect.init(x: 100, y: 100, width: 30, height: 30))
        self.praiseBtn?.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
        self.praiseBtn?.setImage(#imageLiteral(resourceName: "liek_orange"), for: .selected)
        self.praiseBtn?.addTarget(self, action: #selector(self.btnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(self.praiseBtn!)
        
    }
    
    func btnClicked(_ sender:UIButton) -> Void {
        
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - 初始化红包
    func red_paceket() -> Void {
        
        self.view.layer.addSublayer(red_paceketLayer)
        
        //rederMode：控制着在视觉上粒子图片是如何混合的。我们在实例中设置为了KCAEmitterLayerAdditive，它表示这：合并粒子重叠部分的亮度使其更加明亮，其他效果可以尝试下。
//        snowLayer.renderMode = kCAEmitterLayerAdditive
        //emitterPosition：表示粒子发射器的中心位置
        red_paceketLayer.emitterPosition = CGPoint.init(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height-40)
        //设置发射源形状的大小
//        red_paceketLayer.emitterSize = CGSize.init(width: 20, height: 20)
        
        red_paceketCell.name = "red_paceketCell"
        red_paceketCell.contents = #imageLiteral(resourceName: "red_paceket").cgImage
        //设置产生速率
        red_paceketCell.birthRate = 50.0
        //设置消失时间
        red_paceketCell.lifetime = 1.0
        red_paceketCell.alphaSpeed = 0.1
        //设置发射速度
        red_paceketCell.velocity = 150
        red_paceketCell.velocityRange = 100
        //设置发散范围
        red_paceketCell.emissionLongitude = -CGFloat.pi/2
        red_paceketCell.emissionRange = CGFloat.pi/4
        red_paceketLayer.emitterCells = [red_paceketCell]
    }
    
    //MARK:-红包多多
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let lifeTime:Int64 = Int64(red_paceketCell.lifetime + 1.0)
        let birthRate:Int64 = Int64(red_paceketCell.birthRate + 20.0)
        
        self.red_paceketLayer.setValue(NSNumber.init(value: lifeTime), forKeyPath: "emitterCells.red_paceketCell.lifetime")
        self.red_paceketLayer.setValue(NSNumber.init(value: birthRate), forKeyPath: "emitterCells.red_paceketCell.birthRate")
//        self.red_paceketLayer.setValue(UIColor.black.cgColor, forKeyPath: "emitterCells.red_paceketCell.color")
    }
    

}
