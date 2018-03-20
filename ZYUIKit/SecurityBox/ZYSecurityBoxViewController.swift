//
//  ZYSecurityBoxViewController.swift
//  ZYUIKit
//
//  Created by chenzhengying on 2018/3/20.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ZYSecurityBoxViewController: UIViewController {

    let securityBoxView:ZYSecurityBoxView = ZYSecurityBoxView.init(frame: CGRect.init(x: 10, y: 100, width: UIScreen.main.bounds.size.width-2*10, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "类似支付宝密码输入框"

        self.view.addSubview(securityBoxView )
        
        securityBoxView.securityBoxContent = {(_ password:String?) -> Void in
            
            print("password = \(password!)")
        }
        
        
        let clearBtn:UIButton = UIButton.init(type: .custom)
        clearBtn.frame = CGRect.init(x: 30, y: securityBoxView.frame.maxY+50, width: UIScreen.main.bounds.size.width-2*30, height: 30)
        clearBtn.setTitle("清除", for: .normal)
        clearBtn.backgroundColor = UIColor.brown
        clearBtn.addTarget(self, action: #selector(clear(_:)), for: .touchUpInside)
        self.view.addSubview(clearBtn)
    }

    func clear(_ btn:UIButton) -> Void {
        
        securityBoxView.removeAllPassword()
    }
    
}
