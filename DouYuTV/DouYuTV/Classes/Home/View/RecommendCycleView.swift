//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/26.
//

import UIKit

class RecommendCycleView: UIView {
    override  func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件的不随着父控件的拉伸而拉伸
       autoresizingMask = []
    }
    
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil)?.first as! RecommendCycleView
    }
}
