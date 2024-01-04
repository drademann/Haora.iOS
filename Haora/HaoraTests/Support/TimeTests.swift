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
    
    func testNextDay_shouldReturnNextDateAtStartingOfDay() {
        let day1components = DateComponents(year: 2024, month: 1, day: 4, hour: 10, minute: 15, second: 30)
        let day2components = DateComponents(year: 2024, month: 1, day: 5, hour: 0, minute: 0, second: 0)
        
        let date1 = Calendar.current.date(from: day1components)
        let date2 = Calendar.current.date(from: day2components)
        
        XCTAssertEqual(date1?.nextDay(), date2)
    }
    
    func testRound_shouldRoundMinutes_toRequestedInterval() {
        XCTAssertEqual(Time().round(Date().at(10, 00)), Date().at(10, 00))
        XCTAssertEqual(Time().round(Date().at(10, 02)), Date().at(10, 00))
        XCTAssertEqual(Time().round(Date().at(10, 04)), Date().at(10, 05))
        XCTAssertEqual(Time().round(Date().at(10, 05)), Date().at(10, 05))
        XCTAssertEqual(Time().round(Date().at(10, 06)), Date().at(10, 05))
        XCTAssertEqual(Time().round(Date().at(10, 08)), Date().at(10, 10))
        XCTAssertEqual(Time().round(Date().at(10, 11)), Date().at(10, 10))
    }
    
    func testRound_shouldRoundMinutesEqualGreater_58_to_00() {
        XCTAssertEqual(Time().round(Date().at(10, 58)), Date().at(11, 00))
        XCTAssertEqual(Time().round(Date().at(10, 59)), Date().at(11, 00))
        
        XCTAssertEqual(Time().round(Date().at(10, 57)), Date().at(10, 55))
    }
    
    func testRound_shouldRoundMinutesEqualGreater_2358_to_0000_nextDay() {
        XCTAssertEqual(Time().round(Date().at(23, 58)), Date().nextDay())
        XCTAssertEqual(Time().round(Date().at(23, 59)), Date().nextDay())
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
