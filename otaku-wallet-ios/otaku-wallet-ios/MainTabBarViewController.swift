//
//  MainTabBarViewController.swift
//  otaku-wallet-ios
//
//  Created by Tetsuro Takemoto on 2018/04/12.
//  Copyright © 2018 Tetsuro Takemoto. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = Nav1ViewController()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        let nv = UINavigationController(rootViewController: vc)
        let vc2 = Nav2ViewController()
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        let nv2 = UINavigationController(rootViewController: vc2)
        setViewControllers([nv, nv2], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
