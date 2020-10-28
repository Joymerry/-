//
//  RecommendCycleView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/27.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
private let UICollectionViewCellID = "UICollectionViewCell"
class RecommendCycleView: UIView {
    //MARK: - 定义属性
    var cycleModel : [CycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModel?.count ?? 0
        }
    }
    
    //MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: 系统回掉函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
//        AutoresizingMask.flexibleLeftMargin
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 在layoutSubviews获取到的collectionView的frame才是真实的尺寸， awakeFromNib中获取的是xib中的默认尺寸
        // 初始化页面
        self.setUI()
    }
}
//MARK: - 提供一个快速创建view的类方法
extension RecommendCycleView {
    func setUI() {
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: UICollectionViewCellID)
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }
    class func recommendCycleView()->RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK: - 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier:UICollectionViewCellID, for: indexPath) as! CollectionCycleCell
        let cycleModels = cycleModel![indexPath.item]
        item.cycleModel = cycleModels
        return item
    }
}
