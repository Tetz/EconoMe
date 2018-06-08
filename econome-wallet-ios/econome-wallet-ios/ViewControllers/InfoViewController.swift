import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift
import Foundation
import APIKit
import JSONRPCKit
import Geth


final class InfoViewController: UIViewController {
    let titleName: String
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        
        return container
    }()
    
    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        navigationItem.title = titleName

        // View
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // JSON RPC : GetBalance
//        let request = Erc20TokenGetBalance(
//            to: "0x169dbb74352a831c31ff099f066372c8f20da154",
//            data: "0x70a082310000000000000000000000009ae1f5adfcc383b1c5a85e7f0bbad4b768e7d661",
//            quantity: "latest"
//        )
        
        let request = Erc20TokenGetBalance(
            to: "0x169dbb74352a831c31ff099f066372c8f20da154",
            data: "0x70a082310000000000000000000000009ae1f5adfcc383b1c5a85e7f0bbad4b768e7d661",
            quantity: "latest"
        )

        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)
        
        print(httpRequest)

        Session.send(httpRequest) { result in
            switch result {
            case .success(let result):
                print("===== Success: JSONRPC =====")
                let decimalResult =  result
                print(decimalResult)
            case .failure(let error):
                print("===== Error: JSONRPC =====")
                print(error)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
}
