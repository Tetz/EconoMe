//
//  SecondViewController.swift
//  otaku-wallet-ios
//
//  Created by Tetsuro Takemoto on 2018/04/12.
//  Copyright © 2018 Tetsuro Takemoto. All rights reserved.
//

import UIKit
import SnapKit

final class SecondViewController: UIViewController {
    let titleName: String
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.yellow
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
