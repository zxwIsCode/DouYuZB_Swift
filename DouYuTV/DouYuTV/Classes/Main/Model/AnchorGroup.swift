//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/6.
//

import UIKit

class AnchorGroup: NSObject {
    // 以下为了让属性支持KVC，需要加上@objc dynamic属性去修饰
    @objc dynamic var room_list : [[String : NSObject]]? {
        // 监听属性的改变，属性监听器
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }

        }
    }
    @objc dynamic var tag_name: String = ""
    @objc dynamic var icon_name: String = "home_header_normal"
    
    // 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict: [String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        print("key=\(key),value=\(value ?? "")")
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String : NSObject]] {
//                for dict in dataArray {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//
//    }
}
