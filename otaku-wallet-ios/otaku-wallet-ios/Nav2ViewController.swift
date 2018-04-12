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
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Nav2"
        view = tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Nav2ViewController: UITableViewDelegate {
    
}

extension Nav2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
