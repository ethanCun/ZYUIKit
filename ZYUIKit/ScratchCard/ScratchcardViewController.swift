//
//  ScratchcardViewController.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/24.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ScratchcardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let scratchCard:ScratchcardView = ScratchcardView.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 200))
        scratchCard.coverImageView?.image = #imageLiteral(resourceName: "刮刮乐")
        scratchCard.contentsLab?.text = "恭喜中奖了恭喜中奖了恭喜中奖了恭喜中奖了"
        self.view.addSubview(scratchCard)
        
        scratchCard.click = { ()-> Void in
            
            print("click")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
