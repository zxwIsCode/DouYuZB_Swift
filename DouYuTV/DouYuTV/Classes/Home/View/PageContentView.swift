//
//  PageContentView.swift
//  DouYuTV
//
//  Created by DaviD on 2025/9/25.
//

import UIKit

private let ContentCellID = "ContentCellID"

protocol PageContentViewDelegate:class {
    func pageContentView(contentView:PageContentView,progress:CGFloat, sourceIndex:Int, targetIndex:Int)
}

class PageContentView: UIView {
    
    // 自定义属性
    private var childVcs:[UIViewController]
    //  加弱引用weak，防止循环引用，而对象类型只能是可选类型
    private weak var parentVc:UIViewController?
    private var startOffSetX:CGFloat = 0
    private var isForbidScrollDelegate:Bool = false
    weak var delegate:PageContentViewDelegate?
    
    // 闭包里面用到self也要进行weak弱引用
    private lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        
    }()

    init(frame:CGRect, childVcs:[UIViewController],parentVc:UIViewController?) {
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
            parentVc?.addChild(childVc)
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

// 遵守UICollectionViewDelegate协议
extension PageContentView:UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffSetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
//        print("----")
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if(currentOffSetX > startOffSetX) { // 左滑
            progress = currentOffSetX/scrollViewW - floor(currentOffSetX/scrollViewW)
            sourceIndex = Int(currentOffSetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if(targetIndex >= childVcs.count) {
                targetIndex = childVcs.count - 1
            }
            // 如果完全滑过去
            if(currentOffSetX - startOffSetX == scrollViewW) {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        else {// 右滑
            progress = 1 - (currentOffSetX/scrollViewW - floor(currentOffSetX/scrollViewW))
            targetIndex = Int(currentOffSetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if(sourceIndex >= childVcs.count) {
                sourceIndex = childVcs.count - 1
            }
        }
        
//        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int) {
        // 禁止执行代理方法
        isForbidScrollDelegate = true
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}
