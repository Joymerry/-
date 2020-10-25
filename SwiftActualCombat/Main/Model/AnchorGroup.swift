//
//  AnchorGroup.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/20.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
// 在类前加上 @objcMembers，那么它、它的子类、扩展里的方法都会隐式的加上 @objc
@objcMembers
class AnchorGroup: NSObject {
    /// 该数组中对应的房间信息
    @objc var room_list : [[String:NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的标题
    var tag_name : String = ""
    /// 组显示的图标
    var icon_url = "home_header_normal"
    /// 组显示的小图标
    var small_icon_url = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    // MARK:- 自定义构造函数
    override init() {}
    
    init(dict:[String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
