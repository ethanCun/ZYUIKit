//
//  ViewController2.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ViewController2: ZYViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //是否禁用手势 确报在viewWillAppear操作
        (self.navigationController as! ZYNavgationController).panGesDisEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn1:UIButton = UIButton(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 40))
        btn1.backgroundColor = UIColor.red
        btn1.setTitle("手势已禁用", for: .normal)
        btn1.addTarget(self, action: #selector(self.push), for: .touchUpInside)
        self.view.addSubview(btn1)
    }
    
    @objc func push() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

}
