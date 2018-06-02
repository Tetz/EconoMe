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
        
        // Keysotre
        let etherKeystore: EtherKeystore = EtherKeystore()
        etherKeystore.createWalletIfNotExists()
        
        // JSON RPC : GetBalance
//        let request = EthGetBalance(
//            address: address!,
//            quantity: "latest"
//        )
//
//        let batch = batchFactory.create(request)
//        let httpRequest = EthServiceRequest(batch: batch)
//
//        Session.send(httpRequest) { [weak self] result in
//            switch result {
//            case .success(let result):
//                print("===== Success: JSONRPC =====")
//                print(result)
//            case .failure(let error):
//                print("===== Error: JSONRPC =====")
//                print(error)
//            }
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
}
