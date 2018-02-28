//
//  ViewController3.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ViewController3: ZYViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var topView:UIView?
    var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView = UIView.init(frame: CGRect.init(x: 0, y: 84, width: UIScreen.main.bounds.size.width, height: 40))
        topView?.backgroundColor = UIColor.white
        self.view.addSubview(topView!)
        
        for i in 0...3 {
            
            let w:CGFloat = UIScreen.main.bounds.size.width/3
            
            let btn:UIButton = UIButton(frame: CGRect.init(x: w*(CGFloat)(i), y: 0, width: w, height: 40))
            btn.setTitle("第\(i)个", for: .normal)
            btn.setTitleColor(UIColor.brown, for: .normal)
            btn.addTarget(self, action: #selector(self.btnClicked(_:)), for: .touchUpInside)
            btn.tag = 101+i
            topView?.addSubview(btn)
        }
        
        let layOut:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layOut.minimumLineSpacing = 0
        layOut.minimumInteritemSpacing = 0
        layOut.scrollDirection = .horizontal
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: (topView?.frame.maxY)!, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-(topView?.frame.maxY)!), collectionViewLayout: layOut)
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: - btnClicked
    func btnClicked(_ sender:UIButton) -> Void {
        
        let tag:Int = sender.tag-101
        
        collectionView?.scrollToItem(at: IndexPath.init(row: tag, section: 0), at: .left, animated: false)
    }
    
    // MARK: -  UICollectionViewFlowLayout, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.brown][indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-124)
    }
}
