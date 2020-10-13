//
//  RecommendViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/29.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeraderViewID = "kHeraderViewID"

class RecommendViewController: UIViewController {
    //MARK: - 懒加载
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    private lazy var collectionView: UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH) // item的大小
        layout.minimumLineSpacing = 0 // item之间的行间距
        layout.minimumInteritemSpacing = kItemMargin // item之间的间距
        //layout.scrollDirection = .horizontal // 滚动方向
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth] // 根据父试图大小变化
        //collectionView.showsHorizontalScrollIndicator = false // 是否显示水平滚动条
        //collectionView.isPagingEnabled = true
        //collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeraderViewID)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 设置UI界面
        setupUI()
        // 网络请求
        initData()
    }
}
//MARK: - 设置UI界面内容
extension RecommendViewController {
    private func setupUI() {
        // 1.将collectView添加到当前view上
        view.addSubview(collectionView)
    }
}
// MARK:- 请求数据
extension RecommendViewController {
    func initData() {
        // get请求
//        Alamofire.request("http://httpbin.org/get").responseJSON { (response) in
//            guard let result = response.result.value else {
//                print("错误：\(response.result.error!)")
//                return
//            }
//            print("数据：\(result)")
//        }
        
        // post请求
//        Alamofire.request("http://httpbin.org/post", method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil ).responseJSON { (response) in
//            guard let result = response.result.value else {
//                print("错误：\(response.result.error!)")
//                return
//            }
//            print("数据：\(result)")
//        }
        
        // 网络请求
        recommendVM.requestData()
    }
}
//MARK: - UICollectionViewDelegate
extension RecommendViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
//MARK: - UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.定义item
        var item : UICollectionViewCell!
        
        if indexPath.section == 1 {
            item = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as? CollectionPrettyCell
        }else {
            item = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as? CollectionNormalCell
        }
        item.backgroundColor = UIColor.white
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeraderViewID, for: indexPath)
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
}

