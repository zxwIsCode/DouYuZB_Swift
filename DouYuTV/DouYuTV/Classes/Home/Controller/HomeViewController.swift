//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by DaviD on 2025/9/24.
//

import UIKit
import Alamofire

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenWidth, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩",]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.blue
        titleView.delegate = self
        return titleView
        
    }()
    
    private lazy var pageContentView:PageContentView = {[weak self] in
        let contentY = kStatusBarH + kNavigationBarH + kTitleViewH
        let contentH = kScreenHeight - contentY - kTabBarH
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let pageContentView = PageContentView(frame: CGRect(x: 0, y: contentY, width: kScreenWidth, height: contentH), childVcs: childVcs, parentVc: self)
//        pageContentView.backgroundColor = UIColor.red
        pageContentView.delegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        // 网络请求
        // Alamofire的基础使用
//        Alamofire.request("http://httpbin.org/get")
//          .responseJSON { response in
//            // 处理响应数据
//            if let getJson = response.result.value {
//              print("get=\(getJson)")
//            }
//        }
//
//        Alamofire.request("http://httpbin.org/post",method: HTTPMethod.post,parameters: ["name":"hello"])
//          .responseJSON { response in
//            // 处理响应数据
//            if let postjson = response.result.value {
//                print("post=\(postjson)")
//            }
//        }
        
        NetWorkTools.requestData(type: MethodType.GET, URLString: "http://httpbin.org/get") { result in
            print("result=\(result)")
        }
        
        NetWorkTools.requestData(type: MethodType.POST, URLString: "http://httpbin.org/post",parameters: ["name":"hello"]) { result in
            print("result=\(result)")
        }
    }
    


}

// 设置UI界面
extension HomeViewController {
    private func setupUI() {
        // 这个属性加不加没关系的？
//        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏
        setNavigaionBar()
        // 添加titleView
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
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

// 遵守PageTitleViewDelegate的协议
extension HomeViewController:PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
//        print("index=",selectedIndex)
        pageContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
}

// 遵守PageContentViewDelegate的协议
extension HomeViewController:PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
