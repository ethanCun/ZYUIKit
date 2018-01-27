//
//  ProgressTextViewController.swift
//  ZYProgressLabel
//
//  Created by macOfEthan on 2018/1/24.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ProgressTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //给控制器添加一个背景色
        self.view.backgroundColor = UIColor.white
        
        let forward:ZYProgressView = ZYProgressView.init(frame: CGRect.init(x: 20, y: 80, width: 300, height: 90))
        forward.backgroundLabTextColor = UIColor.red
        forward.foregroundLabTextColor = UIColor.green
        forward.text = "forwardforwardforwardforwardforwardforwardforwardforwardforward"
        forward.speed = 2
        forward.backforwards = false
        
        self.view.addSubview(forward)
        
        let backforward:ZYProgressView = ZYProgressView.init(frame: CGRect.init(x: 20, y: 180, width: 300, height: 90))
        backforward.backgroundLabTextColor = UIColor.red
        backforward.foregroundLabTextColor = UIColor.green
        backforward.text = "backforwardbackforwardbackforwardbackforwardbackforwardbackforwardbackforward"
        backforward.speed = 2
        
        //设置往返
        backforward.backforwards = true
        
        self.view.addSubview(backforward)
    }
}
