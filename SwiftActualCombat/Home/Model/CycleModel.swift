//
//  CycleModel.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/27.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
@objcMembers
class CycleModel: NSObject {
    // 标题
    var title : String = ""
    // 展示图片的地址
    var pic_url : String = ""
    // 主播信息对应的字段
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    // MARK: 自定义构造函数
    override init() {}
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
