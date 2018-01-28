//
//  ListViewController.swift
//  ZYProgressLabel
//
//  Created by macOfEthan on 2018/1/24.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .plain)
    var datas:[String?] = ["类似歌词进度文字", "类似刮刮乐", "类似天天快报返回手势","CAEmitterLayer效果"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    // MARK:-UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = datas[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            do {
                let progressTextVc:ProgressTextViewController = ProgressTextViewController()
                self.navigationController?.pushViewController(progressTextVc, animated: true)
            }
            break
        case 1:
            do {
                
                let scratchCardView:ScratchcardViewController = ScratchcardViewController()
                self.navigationController?.pushViewController(scratchCardView, animated: true)
            }
            break
        case 2:
            do {
                
                let v1:ViewController1 = ViewController1()
                self.navigationController?.pushViewController(v1, animated: true)
            }
            break
        case 3:
            do {
                
                let praiseVc:ZYPraiseViewController = ZYPraiseViewController()
                self.navigationController?.pushViewController(praiseVc, animated: true)
            }
            break
        default:
            do {
                
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
