import XCTest
@testable import Haora

final class NowTests: XCTestCase {
    
    func testNow_shouldReturnCurrentTimestamp_withSecondsSetToZero() {
        let now = now()
        
        let components = Calendar.current.dateComponents([.second], from: now)
        XCTAssertEqual(components.second, 0, "now() should set seconds to zero")
    }
}
