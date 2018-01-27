//
//  ZYNavgationController.swift
//  ZYUIKit
//
//  Created by macOfEthan on 2018/1/27.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ZYNavgationController: UINavigationController, UIGestureRecognizerDelegate {

    let screenWidth:CGFloat = UIScreen.main.bounds.size.width
    let screenHeight:CGFloat = UIScreen.main.bounds.size.height
    
    typealias PopBegin = (_ vc:UIViewController) ->Void
    typealias PopChange = (_ vc:UIViewController) ->Void
    typealias PopEnd = (_ vc:UIViewController) ->Void
    
    var popBegin:PopBegin?
    var popChange:PopChange?
    var popEnd:PopEnd?
    
    // MARK: - 拖动手势
    var customPopGes:UIPanGestureRecognizer?
    
    // MARK: - 最小拖动这个距离才返回 默认100.0
    var minPanDistance:CGFloat = 100.0
    
    // MARK: - 保存所有截图的数组
    var screenShotArr:[AnyObject] = [AnyObject]()
    
    // MARK: - 是否打开手势
    var panGesDisEnabled:Bool?  {

        didSet{

            if !panGesDisEnabled! {

                self.interactivePopGestureRecognizer?.isEnabled = false
                self.customPopGes?.isEnabled = true

            }else{

                self.interactivePopGestureRecognizer?.isEnabled = true
                self.customPopGes?.isEnabled = false
            }
        }
    }

    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 禁用系统返回手势 注意在viewDidLoad里面interactivePopGestureRecognizer才被初始化
        self.interactivePopGestureRecognizer?.isEnabled = false
        self.panGesDisEnabled = true
        
        //添加自定义的返回手势
        customPopGes = UIPanGestureRecognizer(target: self, action: #selector(self.customPopPanGes(_:)))
        customPopGes?.delegate = self
        view.addGestureRecognizer(customPopGes!)
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //移除非pan的手势
        guard object_getClass(gestureRecognizer) == UIPanGestureRecognizer.self else {
            return false
        }
        
        //不在导航栏的view上 移除
        guard gestureRecognizer.view == view else {
            return false
        }
        
        let panGes:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        let pointTranslation:CGPoint = panGes.translation(in: view)
        
        // 向左拖动没反应
        guard pointTranslation.x > 0 else {
            return false
        }
        
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //另外一个手势不是下面三种手势类型 直接返回false
        guard object_getClass(otherGestureRecognizer) == NSClassFromString("UIScrollViewPanGestureRecognizer")
            ||
            object_getClass(otherGestureRecognizer) == NSClassFromString("UIPanGestureRecognizer")
            ||
            object_getClass(otherGestureRecognizer) == NSClassFromString("UIScrollViewPagingSwipeGestureRecognizer")
            else{
            
            return false
        }
        
        let gesView = otherGestureRecognizer.view
        
        //不是UIScrollView类型 或子类 直接返回false
        guard (gesView?.isKind(of: UIScrollView.self))! else {
            return false
        }
//This iPhone 6 is running iOS 11.2.5 (15D60), which may not be supported by this version of Xcode.
        //取到scrollView
        let scrollView:UIScrollView = gesView as! UIScrollView
        
        //没有滑到x方向偏移量为0 直接返回false
        guard scrollView.contentOffset.x == 0 else {
            return false
        }
        
        return true
    }

    //MARK:- 处理手势
    @objc func customPopPanGes(_ gesture:UIPanGestureRecognizer) -> Void {
        
        if (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).viewControllers.count <= 1 {
            return
        }
        
        //delegate
        let appDelegate:AppDelegate = UIApplication.shared.delegate as!AppDelegate
        
        //根控制器
        let rootVc:UIViewController = (appDelegate.window?.rootViewController)!
        
        //栈顶控制器
        let topVc:UIViewController = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).topViewController!
        
        //手指移动的距离
        let pointTranslationX:CGFloat = (gesture.translation(in: view) as CGPoint).x
        
        //手指状态
        let state:UIGestureRecognizerState = gesture.state
        
        if state == .began {
            
            appDelegate.screenShotView?.isHidden = false
            
            self.popBegin?(topVc)
            
        }else if state == .changed{
            

            guard pointTranslationX >= 10 else{
                return
            }
            
            self.popChange?(topVc)

            //改变底层视图的大小
            appDelegate.screenShotView?.transform = CGAffineTransform.init(scaleX: 0.95+pointTranslationX/screenWidth*0.06, y: 0.95+pointTranslationX/screenWidth*0.06)
            
            //改变底层视图的图片
            appDelegate.screenShotView?.image = self.screenShotArr.last as? UIImage
            
            //改变顶层控制器视图的位置
            rootVc.view.transform = CGAffineTransform.init(translationX: pointTranslationX-10, y: 0)
            
        }else if state == .ended{
            
            self.popEnd?(topVc)
            
            //拖动大于指定距离
            if pointTranslationX > minPanDistance {
                
                //向右拖动一个width
                UIView.animate(withDuration: 0.5, animations: {
                    
                    //0.5s内 向右平移一个屏幕宽度
                    rootVc.view.transform = CGAffineTransform.init(translationX: self.screenWidth, y: 0)
                    
                }, completion: { (animated:Bool) in
                    
                    _ = self.popViewController(animated: false)
                    
                    //动画结束后回复到原点
                    rootVc.view.transform = CGAffineTransform.identity
                    appDelegate.screenShotView?.isHidden = true
                })
                
            }else{
                
                //pop失败
                UIView.animate(withDuration: 0.2, animations: {
                    
                    //动画结束后回复到原点
                    rootVc.view.transform = CGAffineTransform.identity

                }, completion: { (animated:Bool) in
                    
                    appDelegate.screenShotView?.isHidden = true
                })
            }
        }
    }
    
    // MARK: - 重写pushViewController
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //用户没有push过 就直接返回
        if self.viewControllers.count == 0 {
            
            return super.pushViewController(viewController, animated: animated)

        }else if self.viewControllers.count >= 1{
            
            //隐藏tabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        let appDeleagte:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //每次push都将截屏保存至数组
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: (appDeleagte.window?.bounds.size.width)!, height: (appDeleagte.window?.bounds.size.height)!), true, 0.0)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        appDeleagte.window?.layer.render(in: context)
        
        let screenShot:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.screenShotArr.append(screenShot)
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - 重写popViewController
    override func popViewController(animated: Bool) -> UIViewController? {

        
        guard self.screenShotArr.count > 0 else {
            return super.popViewController(animated: animated)
        }
        
        let screenShotImage:UIImage? = self.screenShotArr.last as? UIImage

        //移除数组的最后一张截图
        self.screenShotArr.removeLast()
        
        guard screenShotImage != nil else {
            return super.popViewController(animated: animated)
        }
        
        let appDeleagte:AppDelegate = UIApplication.shared.delegate as! AppDelegate

        appDeleagte.screenShotView?.image = screenShotImage
        
        
        return super.popViewController(animated: animated)
    }
    
    // MARK: - popToRootViewController
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        //移除除根控制器之外的所有控制器对应的截屏
        let viewVcs:[UIViewController]? = self.viewControllers as [UIViewController]
        
        if (viewVcs?.count)! >= 2 {
            
            self.screenShotArr.removeSubrange(1...self.screenShotArr.count-1)
        }
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let screenShotImage:UIImage? = self.screenShotArr.last as? UIImage
        
        guard screenShotImage != nil else {
            return super.popToRootViewController(animated: animated)
        }
        
        appDelegate.screenShotView?.image = screenShotImage!
        
        return super.popToRootViewController(animated: animated)
    }
    
    // MARK: - popToViewController
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        //所有控制器
        let vcs:[UIViewController]? = self.navigationController?.popToViewController(viewController, animated: animated)
        
        guard self.screenShotArr.count > (vcs?.count)! else {
            return super.popToViewController(viewController, animated: animated)
        }
        
        //遍历移除最后一张截图
        for _ in 0...(vcs?.count)!{
            
            self.screenShotArr.removeLast()
        }
        
        return super.popToViewController(viewController, animated: animated)
    }
    
}



