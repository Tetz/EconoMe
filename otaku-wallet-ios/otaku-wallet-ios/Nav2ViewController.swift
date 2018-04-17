//
//  Nav2ViewController.swift
//  otaku-wallet-ios
//
//  Created by Tetsuro Takemoto on 2018/04/12.
//  Copyright © 2018 Tetsuro Takemoto. All rights reserved.
//

import UIKit
import SnapKit

final class Nav2ViewController: UIViewController {
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.green

        let button = UIButton(type: .system)
        container.addSubview(button)
        button.setTitle("push", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(onTappedPush(_:)), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.center.equalTo(container)
        }
        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Navigation 2"
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func onTappedPush(_ sender: UIButton) {
        print(sender)
        let vc = SecondViewController(titleName: "Second View")
        navigationController?.pushViewController(vc, animated: true)
    }
}
