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
private let kCycleViewH : CGFloat = kScreenW * 3/8
private let kGameViewH : CGFloat = 90

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
    
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        // 设置该控件不随着父控件的拉伸而拉伸
        cycleView.autoresizingMask = [.flexibleLeftMargin]
        return cycleView
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommednGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        // 设置该控件不随着父控件的拉伸而拉伸
        gameView.autoresizingMask = [.flexibleLeftMargin]
        return gameView
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
        
        // 2.将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView添加到UIcollectionView中
        collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
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
        // 1.请求推荐数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            self.gameView.groups = self.recommendVM.anchorGroup
        }
        // 2.请求轮播图数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModel = self.recommendVM.cycleModel
        }
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
        return recommendVM.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroup[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出我们的模型数据
        let group = recommendVM.anchorGroup[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        
        
        // 2.定义item
        var item : CollectionBaseCell!
        
        // 3.去除item
        if indexPath.section == 1 {
            item = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell        }else {
            item = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        // 4.将模型赋值给item
        item.anchor = anchor
        item.backgroundColor = UIColor.white
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeraderViewID, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.white
        
        // 2.取出模型
        let group = recommendVM.anchorGroup[indexPath.section]
        headerView.group = group
        
        return headerView
    }
}

