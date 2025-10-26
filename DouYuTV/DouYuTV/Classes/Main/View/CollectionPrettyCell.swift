//
//  CollectionPrettyCell.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/1.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online / 10000)万在线"
            }
            else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineLabel.text = onlineStr
            
            nickNameLabel.text = anchor.nickname
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
