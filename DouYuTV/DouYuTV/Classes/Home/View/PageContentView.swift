//
//  PageContentView.swift
//  DouYuTV
//
//  Created by DaviD on 2025/9/25.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    // 自定义属性
    private var childVcs:[UIViewController]
    private var parentVc:UIViewController
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        
    }()

    init(frame:CGRect, childVcs:[UIViewController],parentVc:UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    private func setupUI() {
        for childVc in childVcs {
            parentVc.addChild(childVc)
        }
        // 添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
    
    
    
}

// 遵守UICollectionViewDataSource协议

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = self.childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
