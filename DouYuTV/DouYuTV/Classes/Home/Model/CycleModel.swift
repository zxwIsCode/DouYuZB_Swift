//
//  CycleModel.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/27.
//

import UIKit

class CycleModel: NSObject {
    var title : String = ""
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor : AnchorModel?
    
    init(dict:[String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
            
    }
}
