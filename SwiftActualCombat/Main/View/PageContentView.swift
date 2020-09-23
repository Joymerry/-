//
//  PageContentView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/22.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    //MARK: - 定义属性
    private var childVCs:[UIViewController]?
    private var parentViewController : UIViewController?
    
    
    init(frame: CGRect,childVCs:[UIViewController],parentViewController:UIViewController) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
