import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift
import Foundation
import APIKit
import JSONRPCKit
import Geth

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

struct EthNewAccount: JSONRPCKit.Request {
    typealias Response = String
    
    let params: String
    
    var method: String {
        return "personal_newAccount"
    }
    
    var parameters: Any? {
        return [params]
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
        
        // Keysotre
        let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keyStorePath = dataDir + "/keystore"
        print("keyStorePath: \(keyStorePath)")
        
        let keyStoreManager = GethNewKeyStore(keyStorePath, GethLightScryptN, GethLightScryptP)
        let account = try! keyStoreManager?.newAccount("password")
        let address = account?.getAddress().getHex()
        print("address: \(address!)")
        
        let url = account?.getURL()
        print("URL: \(String(describing: url))")
        
        print("=====> Start")
        let fileName = "keystore/UTC--2018-06-01T04-25-35.634795774Z--2f3a3a89bf3e7b7d18ba97b4ca0fcd0595ab2ee9"
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDir = dirPaths[0].path + "/keystore"

        let file = fileName
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            print(fileURL)
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
            }
            catch {/* error handling here */}
        }
        
        // JSON RPC : GetBalance
        let request = EthGetBalance(
            address: address!,
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
