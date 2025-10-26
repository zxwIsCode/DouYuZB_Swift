//
//  CollectionHeaderView.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/1.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchorGroup : AnchorGroup! {
        didSet {
            titleLabel.text = anchorGroup.tag_name
            iconImageView.image = UIImage(named: anchorGroup.icon_name)
        }
    }
    
}
