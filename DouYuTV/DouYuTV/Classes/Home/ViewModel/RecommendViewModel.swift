//
//  RecommandViewModel.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/6.
//

import UIKit

class RecommendViewModel {
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension RecommendViewModel {
    func requestData()  {
        let timeStr = NSDate.getCurrentTime()
        print("timeStr = \(timeStr)")
        // http:capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1759742030
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset": "0", "time":timeStr]) { result in
            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
//                print(group.tag_name)
                for anchor in group.anchors {
                    print(anchor.nickname)
                    
                }
                print("--------")
            }
        }
//        NetWorkTools.requestData(type: .GET, URLString: "http:httpbin.org/get", parameters: ["name":"data"]) { result in
//            print("result=\(result)")
//        }
    }
}
