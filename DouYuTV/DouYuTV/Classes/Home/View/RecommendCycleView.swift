//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by DaviD on 2025/10/26.
//

import UIKit

private let kCycleCellId : String = "kCycleCellId"

class RecommendCycleView: UIView {
    
    var cycleModels:[CycleModel]? {
        didSet {
            // 刷新页面
            self.collectionView.reloadData()
            
            // 设置pageContrl的个数
            self.pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    // 该方法，当从xib中加载出来调用
    override  func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件的不随着父控件的拉伸而拉伸
       autoresizingMask = []
        
        // 注册cell
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellId)
        let nib = UINib(nibName: "CollectionCycleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: kCycleCellId)
        
        
    }
    
    // 比awakeFromNib加载晚一些
    override func layoutSubviews() {
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
}

// 快速创建RecommendCycleView的方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
}
