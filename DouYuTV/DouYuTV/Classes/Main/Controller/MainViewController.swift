//
//  MainViewController.swift
//  DouYuTV
//
//  Created by DaviD on 2025/9/24.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //  测试个颜色
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.red
//        addChild(vc)
        // 添加各个子控制器实现
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
        // Do any additional setup after loading the view.
    }
    
    private func addChildVC(storyName : String) {
        let childVc = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVc)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
