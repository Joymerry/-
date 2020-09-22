//
//  NewsTableViewCell.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/7.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImageView.layer.masksToBounds = true
        headerImageView.layer.cornerRadius = 5.0;
        headerImageView.backgroundColor = UIColor.lightGray
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
