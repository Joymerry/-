//
//  CollectionCycleCell.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/27.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    //MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let url = URL(string: cycleModel?.pic_url ?? "" )
            iconImageView.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
