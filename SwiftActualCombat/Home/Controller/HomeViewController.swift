//
//  HomeViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/8/26.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
private let KTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {
    //MARK: - 懒加载属性
    private lazy var pageTitleView: PageTitleView = {
       let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.purple
        
        return titleView
    }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
    }
    
}
// MARK:- 设置UI
extension HomeViewController {
    func setUI() {
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加titleView
        view.addSubview(pageTitleView)
    }
    
    fileprivate func setupNavigationBar() {
        // 1.设置背景图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
        // 2.标题置空
        navigationItem.titleView = UIView()
        // 3.设置导航栏左视图
//        let leftButton = UIButton()
//        //leftButton.setBackgroundImage(UIImage(named: "logo"), for: .normal)
//        leftButton.setImage(UIImage(named: "logo"), for: .normal)
//        leftButton.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", highImageName: "", size: CGSize(width: 0, height: 0))
        
        // 4.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        // 方式一
        
//        let historyButton = UIButton()
//        historyButton.setImage(UIImage(named: "image_my_history"), for: .normal)
//        historyButton.setImage(UIImage(named: "image_my_history_click"), for: .selected)
//        historyButton.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let historyItem = UIBarButtonItem(customView: historyButton)
        
//        let searchButton = UIButton()
//        searchButton.setImage(UIImage(named: "btn_search"), for: .normal)
//        searchButton.setImage(UIImage(named: "btn_search_clicked"), for: .selected)
//        searchButton.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let searchItem = UIBarButtonItem(customView: searchButton)

//        let qrcodeBtn = UIButton()
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .selected)
//        qrcodeBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
        // 方式二(扩展类方法)
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        // 方式三(构造函数)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
// MARK:- 请求数据
