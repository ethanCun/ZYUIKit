//
//  AppDelegate.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/24.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //截屏视图
    var screenShotView:UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let ListVc:ListViewController = ListViewController()
        
        let ListNav:ZYNavgationController = ZYNavgationController(rootViewController: ListVc);
        
        self.window?.rootViewController = ListNav
        self.window?.backgroundColor = UIColor.black
        self.window?.makeKeyAndVisible()
        
        self.customPopGesture()
        
        return true
    }
    
    func customPopGesture() -> Void {
        
        screenShotView = UIImageView(frame: (self.window?.bounds)!)
        //其实影藏
        screenShotView?.isHidden = true
        //添加到最下面
        self.window?.insertSubview(screenShotView!, at: 0)
    }

}

