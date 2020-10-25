//
//  CollectionBaseCell.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/25.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!

    // 定义模型的属性
    var anchor: AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            // 1.取出在线人数显示的文字
            var onlineStr = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControl.State.normal)
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.显示封面图片
            let url = URL(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: url)
        }
    }
}
