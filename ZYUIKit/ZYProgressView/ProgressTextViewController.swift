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
        backforward.backforwards = true
        
        self.view.addSubview(backforward)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
