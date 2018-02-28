//
//  ZYHoverViewController.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/2/28.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
let KSCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
let KHOVER_VIEW_HEIGHT:CGFloat = 200

var isIOS11:Bool?{
    
    if UIDevice.current.systemVersion.compare("11.0") == ComparisonResult.orderedDescending{
        
        return true
    }
    
    return false
}
var KSTATE_HEIGHT:CGFloat?{
    
    //iphoneX
    if KSCREEN_WIDTH == 375 && KSCREEN_HEIGHT == 812 {
        
        return 44
    }
    
    return 20
}


class ZYHoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hoverTableView:UITableView?
    var headerImageView:UIImageView?
    //顶部视图的承载视图 宽高xy不变
    var bgView:UIView?

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = UIColor.white
        
        self.hoverViewInit()
    }
    
    //MARK:-layout
    func hoverViewInit() -> Void {
        
        self.hoverTableView = UITableView.init(frame: CGRect.init(x: 0, y: KSTATE_HEIGHT!, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT-KSTATE_HEIGHT!), style: .plain)
        self.hoverTableView?.showsVerticalScrollIndicator = false
        self.hoverTableView?.delegate = self
        self.hoverTableView?.dataSource = self
        self.view.addSubview(self.hoverTableView!)
        
        self.bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: KSCREEN_WIDTH, height: KHOVER_VIEW_HEIGHT))
        
        self.headerImageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: KSCREEN_WIDTH, height: KHOVER_VIEW_HEIGHT))
        self.headerImageView?.image = #imageLiteral(resourceName: "liek_orange")
        self.headerImageView?.backgroundColor = UIColor.brown
        self.bgView!.addSubview(self.headerImageView!)
        
        self.hoverTableView?.tableHeaderView = self.bgView
    }
    
    // MARK: - scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY:CGFloat = scrollView.contentOffset.y
        
//        print("offset = \(offsetY)")
        
        if offsetY < 0 {
            
            let totalOffset:CGFloat = KHOVER_VIEW_HEIGHT+abs(offsetY)
            let scale:CGFloat = totalOffset/KHOVER_VIEW_HEIGHT
            
            //滑动后的x坐标 self.hoverView?添加在bgView上
            let x:CGFloat = -(KSCREEN_WIDTH*scale-KSCREEN_WIDTH)/2
            //滑动后的x坐标 就是此时的偏移量 上下滑都一样
            let y:CGFloat = offsetY
            //滑动后的宽度 根据此时总的偏移量作放大缩小
            let width:CGFloat = KSCREEN_WIDTH*scale
            //滑动后的高度 总的偏移量
            let height:CGFloat = totalOffset
            
            self.headerImageView?.frame = CGRect.init(x: x, y: y, width:width, height: height)
        }
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identify:String = "cell"
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify)
        
        if cell == nil {
            
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identify)
        }
        
        cell?.textLabel?.text = String(format: "第%ld行", arguments: [indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 50
    }

}
