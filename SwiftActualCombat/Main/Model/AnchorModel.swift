//
//  AnchorModel.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/20.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
// 在类前加上 @objcMembers，那么它、它的子类、扩展里的方法都会隐式的加上 @objc
@objcMembers
class AnchorModel: NSObject {
    /// 房间ID
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
