//
//  ViewController1.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ViewController1: ZYViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //是否禁用手势 确报在viewWillAppear操作
        (self.navigationController as! ZYNavgationController).panGesDisEnabled = false
        //设置返回触发的最小距离
        (self.navigationController as! ZYNavgationController).minPanDistance = 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let btn1:UIButton = UIButton(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 40))
        btn1.backgroundColor = UIColor.red
        btn1.setTitle("push到下个关闭手势的界面", for: .normal)
        btn1.addTarget(self, action: #selector(self.pushClose), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2:UIButton = UIButton(frame: CGRect.init(x: 0, y: btn1.frame.maxY+100, width: self.view.frame.size.width, height: 40))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("push到下个打开手势的界面", for: .normal)
        btn2.addTarget(self, action: #selector(self.pushOpen), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3:UIButton = UIButton(frame: CGRect.init(x: 0, y: btn2.frame.maxY+100, width: self.view.frame.size.width, height: 40))
        btn3.backgroundColor = UIColor.red
        btn3.setTitle("解决左滑手势与滚动视图的手势冲突实例", for: .normal)
        btn3.addTarget(self, action: #selector(self.solveConflictGes), for: .touchUpInside)
        self.view.addSubview(btn3)
        

        
        let nav:ZYNavgationController = self.navigationController as! ZYNavgationController
        
        nav.popBegin = {(_ vc:UIViewController) ->Void in
            
            print("begin")
        }
        nav.popChange = {(_ vc:UIViewController) ->Void in
            
            print("changed")
        }
        nav.popEnd = {(_vc:UIViewController) ->Void in
            
            print("end")
        }
    }

    func pushOpen() -> Void {
        let v1:ViewController1 = ViewController1()
        self.navigationController?.pushViewController(v1, animated: true)
    }
    
    func pushClose() -> Void {
        let v2:ViewController2 = ViewController2()
        self.navigationController?.pushViewController(v2, animated: true)
    }

    func solveConflictGes() -> Void {
        let v3:ViewController3 = ViewController3()
        self.navigationController?.pushViewController(v3, animated: true)
    }
}
