//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/6.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> NSString {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)" as NSString
    }
}
