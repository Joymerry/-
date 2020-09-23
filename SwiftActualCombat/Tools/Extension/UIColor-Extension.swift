//
//  UIColor-Extension.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/23.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

extension UIColor {
    // 便利构造器
    convenience init(r : CGFloat,g : CGFloat,b : CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func randomColor()->UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
