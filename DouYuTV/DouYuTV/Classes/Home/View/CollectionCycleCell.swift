//
//  CollectionCycleCell.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/27.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            guard let iconURL = URL(string: cycleModel?.anchor?.vertical_src ?? "") else { return }
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
    

}
