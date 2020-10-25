//
//  NSDate-Extension.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/20.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import Foundation
extension NSDate {
    class func getCurrentTime() -> NSString {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)" as NSString
    }
}
