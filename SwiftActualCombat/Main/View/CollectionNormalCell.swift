//
//  CollectionNormalCell.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/29.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    //MARK: - 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // 定义模型的属性
    override var anchor: AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
