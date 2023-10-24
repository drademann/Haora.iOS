import XCTest
@testable import Haora

final class DateExtensionTests: XCTestCase {
    
    func testDateAt_shouldReturnDateAtGivenHourMinute() {
        let dateWithTime = Date().at(10, 15)
        
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: dateWithTime)
        
        XCTAssertEqual(components.hour, 10)
        XCTAssertEqual(components.minute, 15)
        XCTAssertEqual(components.second, 0)
    }
    
}
