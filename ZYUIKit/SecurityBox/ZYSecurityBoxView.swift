//
//  ZYSecurityBoxView.swift
//  ZYUIKit
//
//  Created by chenzhengying on 2018/3/20.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ZYSecurityBoxView: UIView , UITextFieldDelegate {

    
    /**
     密码输入个数
     */
    let securityDotCount:Int = 6

    
    /**
     黑点的大小
     */
    let dotSize:CGSize = CGSize.init(width: 10, height: 10)
    
    
    /**
     整个是一个textField
     */
    var securityTextField:UITextField?
    
    
    /**
     用户输入的密码内容回调
     */
    typealias SecurityBoxContent = (String?)->(Void)
    var securityBoxContent:SecurityBoxContent?
    
    //MARK: -init
    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
        self.textFieldUIInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- UI
    func textFieldUIInit() -> Void {
        
        self.securityTextField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.securityTextField?.delegate = self
        self.securityTextField?.layer.borderWidth = 1
        self.securityTextField?.layer.borderColor = UIColor.black.cgColor
        //移除自动大写
        self.securityTextField?.autocapitalizationType = .none
        //屏蔽textField的显示(设置颜色为clear)
        self.securityTextField?.textColor = UIColor.clear
        self.securityTextField?.tintColor = UIColor.clear
        //设置键盘
        self.securityTextField?.keyboardType = .numberPad
        self.addSubview(self.securityTextField!)
        
        self.securityTextField?.becomeFirstResponder()
        
        //输入改变事件
        self.securityTextField?.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        
        let boxWidth = self.bounds.size.width/(CGFloat)(securityDotCount)
        let boxHeight = self.bounds.size.height
        
        //最后一个line省略
        for i in 0...securityDotCount-1 {
            
            let line:UIView = UIView.init(frame: CGRect.init(x: boxWidth*(CGFloat)(i), y: 0, width: 1, height: boxHeight))
            line.backgroundColor = UIColor.black
            self.addSubview(line)
        }
        
        //添加黑点
        for i in 0...securityDotCount-1 {
            
            let dot:UIView = UIView.init(frame: CGRect.init(x: boxWidth/2+boxWidth*(CGFloat)(i)-dotSize.width/2, y: boxHeight/2-dotSize.height/2, width: dotSize.width, height: dotSize.height))
            dot.layer.cornerRadius = dotSize.width/2
            dot.layer.masksToBounds = true
            dot.backgroundColor = UIColor.black
            dot.tag = 101+i
            self.addSubview(dot)
            
            /**
             初始化全部隐藏
             */
            dot.isHidden = true
        }
    }
    
    //MARK:- UITextFild action
    func textFieldValueChanged(_ textField:UITextField) -> Void {
        
        /**
         显示与隐藏黑点 显示数量为当前textField的长度
         */
        for i in 101...(101+securityDotCount-1) {

            let dotView:UIView = self.viewWithTag(i)!

            if i <= 101+(textField.text?.count)!-1{
                
                dotView.isHidden = false
            }else{
                
                dotView.isHidden = true
            }
        }
        
        if (textField.text?.count)! >= securityDotCount {
            
            self.securityTextField?.resignFirstResponder()
            
            /**
             输入完毕 将密码回调
             */
            if (self.securityBoxContent != nil) {
                
                self.securityBoxContent!(self.securityTextField?.text)
            }
        }
    }

    //MARK:- 清除密码
    public func removeAllPassword() ->Void{
        
        for i in 101...101+securityDotCount-1 {
            
            let dotView:UIView = self.viewWithTag(i)!
            
            dotView.isHidden = true
            
            self.securityTextField?.text = ""
            
            self.securityTextField?.becomeFirstResponder()
        }
    }
    
}
