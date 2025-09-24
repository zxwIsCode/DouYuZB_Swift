//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by DaviD on 2025/9/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    


}

// 设置UI界面
extension HomeViewController {
    private func setupUI() {
        setNavigaionBar()
    }
    
    private func setNavigaionBar() {
        // 设置左侧item布局
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 设置右侧item布局
        
        let size = CGSize(width: 40, height: 40)
        // 方式1，正常写
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
////        historyBtn.sizeToFit()
//        historyBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let historyItem = UIBarButtonItem.init(customView: historyBtn)
//
//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
//        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
////        searchBtn.sizeToFit()
//        searchBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let searchItem = UIBarButtonItem.init(customView: searchBtn)
//
//        let qrcodeBtn = UIButton()
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
////        qrcodeBtn.sizeToFit()
//        qrcodeBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let qrcodeItem = UIBarButtonItem.init(customView: qrcodeBtn)
        // 方式2，通过增加类方法实现
//        let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
//        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        // 方式3，通过构造方法实现
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
                let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
                let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
