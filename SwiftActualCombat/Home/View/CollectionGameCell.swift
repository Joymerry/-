//
//  CollectionGameCell.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/11/2.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    // MARK: 数据属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            let url = URL(string: group?.icon_url ?? "" )
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2.0
    }
}
