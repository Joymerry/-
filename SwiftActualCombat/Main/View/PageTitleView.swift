//
//  PageTitleView.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/9/15.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
//MARK: - 定义属性
private let kScrollLineH:CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
//MARK: - 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleVeiw(titleView: PageTitleView,selectedIndex index : Int)
}

//MARK: - 定义类
class PageTitleView: UIView {
    //MARK: - 定义属性
    private var currentIndex : Int = 0
    private var titles: [String]
    weak var delegate : PageTitleViewDelegate?
    //MARK: - 懒加载属性
    private lazy var titleLabels:[UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        return scrollLine
    }()
    //MARK: - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        super.init(frame: frame)
        
        // 设置UI
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    fileprivate func setUI() {
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds

        // 2.添加title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        // 0.确定label的一些frame的值
        let labelW:CGFloat = kScreenW/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设计label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX:CGFloat = labelW*CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给label添加点击事件
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}
//MARK: - 点击事件
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
//        print(tapGes.view?.tag ?? 0)
        
        // 1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        // 1.1 如果点击的还是当前label 不执行操作
        if tapGes.view?.tag == currentIndex {
            return
        }
        
        // 2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换label的字体颜色
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        // 4.保存当前label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条的位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知delegate
        delegate?.pageTitleVeiw(titleView: self, selectedIndex: currentIndex)
    }
}
//MARK: - 对外暴露的方法
extension PageTitleView {
    func setTitleViewProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        // 1.获取到sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1 取出变化的范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        
        // 3.2 变化sorceLbael
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        
        // 3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
