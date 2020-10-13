//
//  NetworkTools.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/10/13.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    class func requestData(type : MethodType , URLString : String , parameters : [String : NSString]? = nil , finishedCallback : @escaping (_ result : Any)->()) {
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            // 3.获取数据
            guard let result = response.result.value else {
                print("错误:\(String(describing: response.result.error))")
                return
            }
            // 4.将结果回调回去
            finishedCallback(result)
        }
    }
}
