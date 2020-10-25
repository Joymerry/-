//
//  CollectionPrettyCell.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/29.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    //MARK: 控件属性
    
    @IBOutlet weak var cityButton: UIButton!
    
    // 定义模型的属性
    override var anchor: AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.显示所在城市
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
