//
//  PageTitleView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/15.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    //MARK: - 定义属性
    private var titles: [String]
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        super.init(frame: frame)
        
        // 设置UI
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    fileprivate func setUI() {
        
    }
}
