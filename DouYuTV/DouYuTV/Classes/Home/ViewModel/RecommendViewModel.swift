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
        // 1.请求0部分推荐数据
        // http:capi.douyucdn.cn/api/v1/getbigDataRoom?time=1759742030
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: [ "time":timeStr]) { result in
            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            let group = AnchorGroup()
            group.tag_name = "热门"
            group.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
        }
        
        // 2.请求1部分颜值数据
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit" : "4", "offset": "0", "time":timeStr]) { result in
//            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            let group = AnchorGroup()
            group.tag_name = "颜值"
            group.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
        }
        // 3.请求2-12部分游戏数据
        // http:capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1759742030
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset": "0", "time":timeStr]) { result in
//            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
//            for group in self.anchorGroups {
////                print(group.tag_name)
//                for anchor in group.anchors {
//                    print(anchor.nickname)
//
//                }
//                print("--------")
//            }
        }
//        NetWorkTools.requestData(type: .GET, URLString: "http:httpbin.org/get", parameters: ["name":"data"]) { result in
//            print("result=\(result)")
//        }
    }
}
