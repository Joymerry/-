//
//  CollectionHeaderView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/29.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
//            print(group?.icon_url ?? "")

            if group?.tag_name == "热门" ||  group?.tag_name == "颜值" {
                // 加载本地图片
                iconImageView.image = UIImage.init(named: group?.icon_url ?? "home_header_normal")
            }else {
                // 加载网络图片
                let url = URL(string: group?.icon_url ?? "")
                iconImageView.kf.setImage(with: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
