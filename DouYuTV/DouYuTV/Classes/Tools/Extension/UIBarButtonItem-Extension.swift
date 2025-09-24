//
//  UIBarButtonItem-Extension.swift
//  DouYuTV
//
//  Created by DaviD on 2025/9/24.
//

import UIKit

extension UIBarButtonItem {
//    class func creatItem(imageName:String, highImageName:String, size:CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    // 便利构造函数，1，以convenience开头；2，构造函数中必须明确调用设计的构造函数（以self来调用）
    convenience init(imageName:String, highImageName:String = "", size:CGSize = CGSize(width: 0, height: 0)) {
        let btn = UIButton()
                btn.setImage(UIImage(named: imageName), for: .normal)
        if(highImageName != "") {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
                
                
        if(size == CGSize(width: 0, height: 0)) {
            btn.sizeToFit()
        }
        else {
            btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
        self.init(customView: btn)
    }
}
