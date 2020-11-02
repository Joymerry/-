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
    var cycleTimer : Timer?
    
    var cycleModel : [CycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModel?.count ?? 0
            
            // 3.轮播图默认滚动到中间的某个位置
            let indexPath = NSIndexPath(item: (cycleModel?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    //MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: 系统回掉函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸(无效代码，在外部调用时设置)
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
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        // 设置偏移量也能实现轮播图默认滚动在中间位置的效果
//        collectionView.contentOffset = CGPoint(x: collectionView.frame.width * 600, y: 0)
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
        return (cycleModel?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier:UICollectionViewCellID, for: indexPath) as! CollectionCycleCell
        let cycleModels = cycleModel![indexPath.item%(cycleModel!.count)]
        item.cycleModel = cycleModels
        return item
    }
}
// MARK: - 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width/2
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)%(cycleModel?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 开始拖拽的时候结束定时器
        removeCycleTimer()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // 结束拖拽的时候开启定时器
        addCycleTimer()
    }
}
// MARK: - 对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    private func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext (){
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
