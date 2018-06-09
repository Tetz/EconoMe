import Foundation
import APIKit

protocol TokenDataRequest: Request {}
extension TokenDataRequest {
    var baseURL: URL {
        return URL(string: "https://api.coinmarketcap.com/v2")!
    }
}

struct GetTokenDataRequest: TokenDataRequest {
    typealias Response = TokenData

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/ticker/1765/"
    }

    var parameters: Any? {
        return ["convert": "JPY"]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dictionary = object as? [String: [String: AnyObject]],
              let tokenData = TokenData(dictionary: dictionary) else {
            throw ResponseError.unexpectedObject(object)
        }

        return tokenData
    }
}

struct TokenData {
    let price: Optional<Double>
    let percent_change_1h: Optional<Double>
    let percent_change_24h: Optional<Double>
    let percent_change_7d: Optional<Double>

    init?(dictionary: [String: [String: AnyObject]]) {
        guard let tokenData = dictionary["data"]?["quotes"]?["JPY"] as? AnyObject else {
            return nil
        }
        self.price = tokenData["price"] as? Double
        self.percent_change_1h = tokenData["percent_change_1h"] as? Double
        self.percent_change_24h = tokenData["percent_change_24h"] as? Double
        self.percent_change_7d = tokenData["percent_change_7d"] as? Double
    }
}

