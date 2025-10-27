//
//  RecommandViewModel.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/6.
//

import UIKit

class RecommendViewModel {
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension RecommendViewModel {
    // 请求推荐数据
    func requestData( finishCallback :@escaping () -> ())  {
        let timeStr = NSDate.getCurrentTime()
        print("timeStr = \(timeStr)")
        
        let dGroup = DispatchGroup.init()
        dGroup.enter()
        // 1.请求0部分推荐数据
        // http:capi.douyucdn.cn/api/v1/getbigDataRoom?time=1759742030
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: [ "time":timeStr]) { result in
//            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
//            print("推荐数据完成")
            dGroup.leave()
        }
        
        // 2.请求1部分颜值数据
        dGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit" : "4", "offset": "0", "time":timeStr]) { result in
//            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
//            print("颜值数据完成")
        }
        // 3.请求2-12部分游戏数据
        // http:capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1759742030
        dGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset": "0", "time":timeStr]) { result in
//            print("result=\(result)")
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dGroup.leave()
//            print("其他数据完成")
            
//            for group in self.anchorGroups {
////                print(group.tag_name)
//                for anchor in group.anchors {
//                    print(anchor.nickname)
//
//                }
//                print("--------")
//            }
        }
        dGroup.notify(queue: .main) {
//                    print("全部请求完成了")
            // 闭包里面需要给对应的属性前面加上self.的情况
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
                }
//        NetWorkTools.requestData(type: .GET, URLString: "http:httpbin.org/get", parameters: ["name":"data"]) { result in
//            print("result=\(result)")
//        }
    }
    
    func requestCycleData( finishCallback :@escaping () -> ())  {
        NetWorkTools.requestData(type: .GET, URLString: "http:capi.douyucdn.cn/api/v1/slide/6", parameters: ["version":"2.300"]) { result in
            print("result = \(result)")
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            for dict in dataArr {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }

    }
}
