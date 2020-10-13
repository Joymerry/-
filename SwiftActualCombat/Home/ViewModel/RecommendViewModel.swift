//
//  RecommendViewModel.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/13.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
}
//MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData() {
        // 1.请求推荐数据
        NetworkTools.requestData(type: .POST, URLString: "http://httpbin.org/post") { (result) in
            print("数据111：\(result)")
        }
        
        // 2.请求颜值数据
        
        // 3.请求后面部分的游戏数据
    }
}
