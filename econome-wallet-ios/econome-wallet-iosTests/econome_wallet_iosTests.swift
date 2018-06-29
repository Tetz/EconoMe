import XCTest
@testable import econome_wallet_ios
import APIKit
import Geth

class econome_wallet_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }


    func testTokenDataApi_get() {
        let request = GetTokenDataRequest()

        Session.send(request) { result in
            switch result {
            case .success(let token):
                print("tokenData: \(token)")

            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    func test_Erc20Token_generateTransaction() {
        let erc20 = Erc20Token()
        let _ = erc20.generateTransaction(nonce: Int64(1), to: "")

        let result = "hoge"
        let expectedData = "0xa9059cbb0000000000000000000000009aE1f5ADFcc383B1C5a85e7f0BBaD4b768e7D6610000000000000000000000000000000000000000000000000000000000000064"

        XCTAssertEqual(result, expectedData)
    }

}
