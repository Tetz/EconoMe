import XCTest
@testable import econome_wallet_ios

class econome_wallet_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTokenDataApi_get() {
        XCTAssertEqual(TokenDataApi().get(), 100)
    }

}
