//
//  MineViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/8/26.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
import ESPullToRefresh
import MJRefresh

class MineViewController: UIViewController {

    let top_header_style = MJRefreshGifHeader()//这个可以设置下拉刷新的图片动画效果
    let footer_style = MJRefreshAutoNormalFooter()
    
    
    lazy var tableView: UITableView = {[weak self] in
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
        // 下拉刷新
        top_header_style.setRefreshingTarget(self as Any, refreshingAction: #selector(MineViewController.headerRefresh))
        tableView.mj_header = top_header_style
        
        // 上拉加载
        footer_style.setRefreshingTarget(self as Any, refreshingAction: #selector(MineViewController.footerRefresh))
        tableView.mj_footer =  footer_style
        return tableView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
    }
}

extension MineViewController {
    func setUI() {
        view.addSubview(tableView)
    }
    
    fileprivate func setupNavigationBar() {
        // 1.设置背景图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
    }
    
    @objc func toVODVc() {
        let VC = VODViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    //顶部下拉刷新时执行的函数
    @objc func headerRefresh(){
        print("下拉刷新")
        //结束下拉刷新
        self.tableView.mj_header!.endRefreshing()
    }
    
    @objc func footerRefresh() {
        print("上拉加载")
//        self.tableView.mj_footer!.endRefreshing()
//        self.tableView.mj_footer!.endRefreshingWithNoMoreData()
    }
}
// MARK:- 请求数据
extension MineViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = VODViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
