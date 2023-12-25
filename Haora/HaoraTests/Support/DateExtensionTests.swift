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
  
  func testWithoutTime_shouldEraseTimeComponents() {
    guard let date = ISO8601DateFormatter().date(from: "2023-11-26T10:15:00Z") else { return XCTFail("could not parse date") }
    
    let dateWithoutTime = date.asDay()
    
    let components = Calendar.current.dateComponents([.hour, .minute, .second], from: dateWithoutTime)
    XCTAssertEqual(components.hour, 0)
    XCTAssertEqual(components.minute, 0)
    XCTAssertEqual(components.second, 0)
  }
  
  func testAsTimeString_shouldFormatTimeComponentsOfDateAsString() {
    let date = Date().at(15, 15)
    
    let timeString = date.asTimeString()
    
    XCTAssertEqual(timeString, "15:15")
  }
  
  func testAsTimeString_shouldFormatOneDigitHoursAndMinutes() {
    let date = Date().at(9, 01)
    
    let timeString = date.asTimeString()
    
    XCTAssertEqual(timeString, "9:01")
  }
}
