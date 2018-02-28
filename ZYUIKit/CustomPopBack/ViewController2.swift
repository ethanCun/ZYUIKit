//
//  ViewController2.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit


@objcMembers
class ViewController2: ZYViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //是否禁用手势 确报在viewWillAppear操作
        (self.navigationController as! ZYNavgationController).panGesDisEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn2:UIButton = UIButton(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 40))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("手势已禁用", for: .normal)
        btn2.addTarget(self, action: #selector(self.push), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn4:UIButton = UIButton(frame: CGRect.init(x: 0, y: btn2.frame.maxY+100, width: self.view.frame.size.width, height: 40))
        btn4.backgroundColor = UIColor.red
        btn4.setTitle("pop到根控制器", for: .normal)
        btn4.addTarget(self, action: #selector(self.popToRootVc), for: .touchUpInside)
        self.view.addSubview(btn4)
        
        let btn5:UIButton = UIButton(frame: CGRect.init(x: 0, y: btn4.frame.maxY+100, width: self.view.frame.size.width, height: 40))
        btn5.backgroundColor = UIColor.red
        btn5.setTitle("pop到指定控制器", for: .normal)
        btn5.addTarget(self, action: #selector(self.popToVc), for: .touchUpInside)
        self.view.addSubview(btn5)
    }
    
    func push() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToRootVc() -> Void {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func popToVc() -> Void {
        
        var v1:ViewController1?
        for vc:UIViewController in (self.navigationController?.viewControllers)! {
            
            if object_getClass(vc) == ViewController1.self{
                
                v1 = vc as? ViewController1
            }
        }
        
        guard v1 != nil else {
            return
        }
        
        self.navigationController?.popToViewController(v1!, animated: true)
    }
}
