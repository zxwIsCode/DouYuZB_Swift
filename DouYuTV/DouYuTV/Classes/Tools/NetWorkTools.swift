//
//  NetWorkTools.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/5.
//

import UIKit
import Alamofire

enum MethodType {
case GET
    case POST
}

class NetWorkTools {
    
    class func requestData(type:MethodType,URLString:String,parameters:[String:NSString]? = nil, finishedCallback:@escaping (AnyObject) -> ()) {
        let method = type == MethodType.GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString,method: method,parameters: parameters).responseJSON { response in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallback(result as AnyObject)
//            print(result)
        }
        
    }
 
}
