//
//  RecommendGameView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/11/1.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
private let UICollectionViewCellID = "CollectionGameCell"
private let kEdgeInsetMargin : CGFloat = 10
class RecommendGameView: UIView {
    // MARK: 定义数据属性
    var groups : [AnchorGroup]? {
        didSet {
            // 1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            // 3.刷新表格
            collectionView.reloadData()
        }
    }
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: 系统回掉函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸(无效代码，在外部调用时设置)
//        AutoresizingMask.flexibleLeftMargin
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 创建UI
        setUI()
    }
}
extension RecommendGameView {
    func setUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: UICollectionViewCellID, bundle: nil), forCellWithReuseIdentifier: UICollectionViewCellID)
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }
}
// MARK: - 提供一个快速创建的类方法
extension RecommendGameView {
    class func recommednGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
// MARK: - 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCellID, for: indexPath) as! CollectionGameCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ?UIColor.red:UIColor.green
        let group = groups?[indexPath.item]
        cell.group = group
        return cell
    }
}
// MARK: - 遵守UICollectionView的代理协议
extension RecommendGameView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了：\(indexPath.item)")
    }
}
