//
//  ScratchcardViewController.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/24.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ScratchcardViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (self.navigationController as! ZYNavgationController).panGesDisEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //给控制器添加一个背景色
        self.view.backgroundColor = UIColor.white
        
        let scratchCard:ScratchcardView = ScratchcardView.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 200))
        scratchCard.coverImageView?.image = #imageLiteral(resourceName: "刮刮乐")
        scratchCard.contentsLab?.text = "恭喜中奖了恭喜中奖了恭喜中奖了恭喜中奖了"
        self.view.addSubview(scratchCard)
        
        scratchCard.click = { ()-> Void in
            
            print("click")
        }

    }

}
