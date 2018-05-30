import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift
import Foundation
import APIKit
import JSONRPCKit

struct EthServiceRequest<Batch: JSONRPCKit.Batch>: APIKit.Request {
    let batch: Batch
    typealias Response = Batch.Responses
    
    var baseURL: URL {
        return URL(string: "https://ropsten.infura.io/xyji23ngACpAtbvoO0MZ")!
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/"
    }
    
    var parameters: Any? {
        return batch.requestObject
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try batch.responses(from: object)
    }
}

struct CastError<ExpectedType>: Error {
    let actualValue: Any
    let expectedType: ExpectedType.Type
}

struct EthGetBalance: JSONRPCKit.Request {
    typealias Response = String
    
    let address: String
    let quantity: String
    
    var method: String {
        return "eth_getBalance"
    }
    
    var parameters: Any? {
        return [address, quantity]
    }
    
    func response(from resultObject: Any) throws -> Response {
        if let response = resultObject as? Response {
            return response
        } else {
            throw CastError(actualValue: resultObject, expectedType: Response.self)
        }
    }
}

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
        
        // JSON RPC
        let request = EthGetBalance(
            address: "0x5F5FAb2be7F41624CF841A393300cCc651674Dc5",
            quantity: "latest"
        )
        
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)
        
        Session.send(httpRequest) { [weak self] result in
            switch result {
            case .success(let result):
                print("===== Success: JSONRPC =====")
                print(result)
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