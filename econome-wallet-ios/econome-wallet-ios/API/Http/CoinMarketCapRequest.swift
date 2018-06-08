import Foundation
import APIKit

protocol CoinMarketCapRequest: Request {
    
}

extension CoinMarketCapRequest {
    var baseURL: URL {
        return URL(string: "https://api.coinmarketcap.com/v2")!
    }
}

struct Token {
    let price: Double
    
    init?(dictionary: [String: [String: AnyObject]]) {
         guard let price = dictionary["data"]?["quotes"]?["JPY"] as? AnyObject else {
            return nil
        }
        
        guard let priceAsDouble = price["price"] as? Double else {
            return nil
        }

        self.price = priceAsDouble
    }
}

struct GetPriceRequest: CoinMarketCapRequest {
    typealias Response = Token
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/ticker/1027/"
    }
    
    var parameters: Any? {
        return ["convert": "JPY"]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dictionary = object as? [String: [String:  AnyObject]],
            let token = Token(dictionary: dictionary) else {
                throw ResponseError.unexpectedObject(object)
        }
        
        return token
    }
}
