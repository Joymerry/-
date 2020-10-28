//
//  RecommendViewModel.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/13.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //MARK: - 懒加载属性
    lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModel : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}
//MARK: - 发送网络请求
extension RecommendViewModel {
    // 请求推荐的数据
    func requestData(finishCallback:@escaping ()->()) {
        // 1.定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        // 2.创建group
        let group:DispatchGroup = DispatchGroup.init()
        
        // 3.请求第一部分推荐数据
        // 进入组
        group.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String:NSObject] else {
                return
            }
            
            // 2.根据data该key 获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {
                return
            }
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            // 3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 3.3 离开组
            group.leave()
            print("请求成功1")
        }
        
        // 4.请求颜值数据
        // 进入组
        group.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //print("颜值数据：\(result)")
            // 1.将result转成字典类型
            guard let resultDict = result as? [String:NSObject] else {
                return
            }
            
            // 2.根据data该key 获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {
                return
            }
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            // 3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3 离开组
            group.leave()
            print("请求成功2")
        }
        
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024
        // 5.请求后面部分的游戏数据
        group.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            // 2.根据data该key 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroup.append(group)
            }
            
            // 4 离开组
            group.leave()
            print("请求成功3")
        }
        
        // 6.所有的数据都请求到之后进行排序
        group.notify(queue: DispatchQueue.main) {
            print("请求成功4")
            self.anchorGroup.insert(self.prettyGroup, at: 0)
            self.anchorGroup.insert(self.bigDataGroup, at: 0)
            
            print(self.anchorGroup.count,self.anchorGroup)
            for ahchor in self.anchorGroup {
                print(ahchor.tag_name)
            }

            finishCallback()
        }
    }
    
    // 请求无限轮播的数据
    func requestCycleData(finishCallback:@escaping ()->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String:NSObject] else {return}
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            // 3.字典模型转对象
            for dict in dataArray {
                self.cycleModel.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
