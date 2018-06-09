import XCTest
@testable import econome_wallet_ios
import APIKit

class econome_wallet_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // TODO
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

}
