//
//  AnchorModel.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/6.
//

import UIKit

class AnchorModel: NSObject {
    @objc dynamic var room_id : Int = 0
    @objc dynamic var vertical_src : String = ""
    // 0-电脑直播，1-手机直播
    @objc dynamic var isVertical : Int = 0
    
    @objc dynamic var room_name : String = ""
    
    @objc dynamic var nickname : String = ""
    // 在线人数
    @objc dynamic var online : Int = 0
    
    
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
