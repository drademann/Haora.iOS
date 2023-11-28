import XCTest
@testable import Haora

final class TimeIntervalExtensionTests: XCTestCase {
  
  func testAsString_given() {
    let duration: TimeInterval = DateInterval(start: Date().at(9,15), end: Date().at(12,00)).duration
    
    let formattedDuration = duration.asString()
    
    XCTAssertEqual(formattedDuration, "2 hrs, 45 min")
  }
}
