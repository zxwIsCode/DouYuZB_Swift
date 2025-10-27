//
//  CycleModel.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/27.
//

import UIKit

class CycleModel: NSObject {
    // 以下为了让属性支持KVC，需要加上@objc dynamic属性去修饰
    @objc dynamic var title : String = ""
    @objc dynamic var pic_url : String = ""
    // 主播信息对应的字典
    @objc dynamic var room : [String : NSObject]? {
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
