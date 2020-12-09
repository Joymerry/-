//
//  GameViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/11/9.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3.0
private let kItemH : CGFloat = kItemW * 6 / 5

class GameViewController: UIViewController {
    // MARK: 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
        
//        // 1.创建layout
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH) // item的大小
//        layout.minimumLineSpacing = 0 // item之间的行间距
//        layout.minimumInteritemSpacing = kItemMargin // item之间的间距
//        //layout.scrollDirection = .horizontal // 滚动方向
//        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
//
//        // 2.创建UICollectionView
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth] // 根据父试图大小变化
//        //collectionView.showsHorizontalScrollIndicator = false // 是否显示水平滚动条
//        //collectionView.isPagingEnabled = true
//        //collectionView.bounces = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = UIColor(r: 255, g: 255, b: 255)
//        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
//        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
//        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeraderViewID)
//        return collectionView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        setUI()
    }
}
extension GameViewController {
    func setUI(){
        view.addSubview(collectionView)
    }
}
