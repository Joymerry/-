//
//  PageContentView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/22.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate: class {
    func pageContentView(pageContenView: PageContentView, progress : CGFloat,sourceIdnex: Int,targetIndex:Int)
}
private let CollectViewID = "UICollectionViewCell"
class PageContentView: UIView {
    //MARK: - 定义属性
    private var childVCs: [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollViewDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    //MARK: - 懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectViewID)
        return collectionView
    }()
    
    init(frame: CGRect,childVCs:[UIViewController],parentViewController:UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - 设置UI界面
extension PageContentView {
    fileprivate func setupUI() {
        // 1.将所有的子控制器添加到父控制器上
        for childVC in childVCs {
            parentViewController?.addChild(childVC)
        }
        
        // 2.添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//MARK: - UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CollectViewID, for: indexPath)
        
        // 2.给cell设置内容
        for view in item.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = item.contentView.bounds
        item.contentView.addSubview(childVC.view)
        return item
    }
}
//MARK: - UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 开始拖动不禁止
        isForbidScrollViewDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("---")
        // 0.判断如果禁止的话 就返回
        if isForbidScrollViewDelegate {
            return
        }
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左划还是右划
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左划
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        }else { // 右划
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            
//            // 4.如果完全划过去
//            if currentOffsetX - startOffsetX == scrollViewW {
//                progress = 1.0
//                targetIndex = sourceIndex
//            }
        }
        
        // 3.讲progress/sourceIndex/targetIndex传递给titleView
        print("progress\(progress) sourceIndex\(sourceIndex) targetIndex\(targetIndex)")
        
        delegate?.pageContentView(pageContenView: self,progress: progress, sourceIdnex: sourceIndex, targetIndex: targetIndex)
    }
}
//MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        // 1.外部点击不允许在此走代理中的计算方法
        isForbidScrollViewDelegate = true
        
        // 2.设置偏移量
        UIView.animate(withDuration: 0.15) {
            let offsetX = CGFloat(currentIndex) * self.collectionView.frame.width
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
    }
}
