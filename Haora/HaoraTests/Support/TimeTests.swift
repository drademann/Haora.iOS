import XCTest
@testable import Haora

final class TestTime: Time {
    
    var testNow: Date
    var testToday: Date
    
    init(now: Date = Date.now.asTime(), today: Date = Date.now.asDay()) {
        self.testNow = now
        self.testToday = today
    }
    
    override func now() -> Date {
        return testNow
    }
    
    override func today() -> Date {
        return testToday
    }
}

final class TimeTests: XCTestCase {
    
    func testRound_shouldRoundMinutes_toRequestedInterval() {
        XCTAssertEqual(Time().round(Date().at(10, 00)), Date().at(10, 00))
        XCTAssertEqual(Time().round(Date().at(10, 02)), Date().at(10, 00))
        XCTAssertEqual(Time().round(Date().at(10, 04)), Date().at(10, 05))
        XCTAssertEqual(Time().round(Date().at(10, 05)), Date().at(10, 05))
        XCTAssertEqual(Time().round(Date().at(10, 06)), Date().at(10, 05))
        XCTAssertEqual(Time().round(Date().at(10, 08)), Date().at(10, 10))
        XCTAssertEqual(Time().round(Date().at(10, 11)), Date().at(10, 10))
    }
    
    func testNow_shouldProvideCurrentTime_roundedToRequestedInterval() {
        let time = Time()
        
        let dateNow = Date.now
        let now = time.now()
        
        XCTAssertNotNil(now)
        let dateNowComponents = Calendar.current.dateComponents([.minute], from: dateNow)
        let expectedMinute = switch (dateNowComponents.minute! % 10) {
            case 8, 9, 0, 1, 2: 0
            case 3, 4, 5, 6, 7: 5
            default: -1
        }
        let nowComponents = Calendar.current.dateComponents([.minute], from: now)
        XCTAssertEqual(nowComponents.minute! % 10, expectedMinute)
    }
}
