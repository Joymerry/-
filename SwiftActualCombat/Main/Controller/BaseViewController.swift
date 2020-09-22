//
//  BaseViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/4.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var contenView: UIView?
    
    fileprivate lazy var animImageView: UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        return imageView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
