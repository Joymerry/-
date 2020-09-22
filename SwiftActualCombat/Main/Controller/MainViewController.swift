//
//  MainViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/8/26.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("yejinlaile")
        // Do any additional setup after loading the view.
        
        addChildViewController(childController: HomeViewController(), title: "首页", imageName: "btn_home_normal",selectName: "btn_home_selected")
        addChildViewController(childController: LiveViewController(), title: "直播", imageName: "btn_live_normal",selectName:"btn_live_selected")
        addChildViewController(childController: MineViewController(), title: "用户", imageName: "btn_user_normal",selectName:"btn_user_selected")
    }
    
    func addChildViewController(childController:UIViewController,title: String,imageName:String,selectName:String)  {
        // 1.添加自控制器
        tabBar.tintColor = UIColor.orange
        
        let homeVC = childController
        homeVC.tabBarItem.image = UIImage(named: imageName)
        homeVC.tabBarItem.selectedImage = UIImage(named: selectName)
        homeVC.title = title
        
        let nav = UINavigationController(rootViewController: homeVC)
//        nav.navigationBar.barTintColor = UIColor.purple
        addChild(nav)
    }
}
