import Foundation
import APIKit
import JSONRPCKit

struct CastError<ExpectedType>: Error {
    let actualValue: Any
    let expectedType: ExpectedType.Type
}

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

struct Erc20TokenGetBalance: JSONRPCKit.Request {
    typealias Response = String
    
    let to: String
    let data: String
    let quantity: String
    
    var method: String {
        return "eth_call"
    }
    
    var parameters: Any? {
        
        let jsonObj = [
            "to": to,
            "data": data
        ]
        
        return [ jsonObj, quantity]
    }
    
    func response(from resultObject: Any) throws -> Response {
        if let response = resultObject as? Response {
            return response
        } else {
            throw CastError(actualValue: resultObject, expectedType: Response.self)
        }
    }
}

