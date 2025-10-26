//
//  CollectionNormalCell.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/1.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    var anchor: AnchorModel? {
        didSet {
            var onlineStr : String = ""
            if (anchor?.online ?? 0) >= 10000 {
                onlineStr = "\((anchor?.online ?? 0) / 10000)万在线"
            }
            else {
                onlineStr = "\((anchor?.online ?? 0))在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor?.nickname
            
            guard let iconURL = URL(string: anchor?.vertical_src ?? "") else { return }
            iconImageView.kf.setImage(with: iconURL)
            
            roomNameLabel.text = anchor?.room_name
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
