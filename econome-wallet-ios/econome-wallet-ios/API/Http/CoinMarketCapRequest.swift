import Foundation
import APIKit

protocol CoinMarketCapRequest: Request {
    
}

extension CoinMarketCapRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension CoinMarketCapRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

struct SearchTokensResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let id: Int
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}

final class CoinMarketCapAPI {
    private init() {}
    
    struct SearchTokens: CoinMarketCapRequest {
        typealias Response = SearchTokensResponse
        
        let method: HTTPMethod = .get
        let path: String = "/search/repositories"
        var parameters: Any? {
            return ["q": query, "page": 1]
        }
        
        let query: String
    }
}
