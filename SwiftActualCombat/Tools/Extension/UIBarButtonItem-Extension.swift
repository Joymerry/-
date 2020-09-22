//
//  UIBarButtonItem-Extension.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/9.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // 扩展类方法
    class func createItem(imageName:String,highImageName:String,size:CGSize)-> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .selected)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    // 构造函数 (1.便利构造函数 convenience开头 2.便利构造函数内部必须调用一个设计构造函数)
    public convenience init(imageName:String,highImageName:String = "",size:CGSize) {
        // 1.创建UIButton
        let btn = UIButton()
        
        //2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .selected)
        }
        
        //3.设置btn的尺寸
        if size != CGSize(width: 0, height: 0) {
            btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }else {
            btn.sizeToFit()
        }
        
        //4.设置UIBarButtonItem
        // 设计构造函数
        self.init(customView: btn)
    }
}
