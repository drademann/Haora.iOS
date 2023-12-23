import XCTest
@testable import Haora

final class TaskDurationTests: XCTestCase {
    
    func testDuration_givenNextTaskIsNil_shouldReturnDurationToNow() {
        let task = Task(start: Date().at(8, 00), text: "Task")
        
        let duration = task.duration(to: nil, currentDate: Date().at(10, 00))
        
        XCTAssertEqual(duration, 2 * 60 * 60, "duration should be 2 hours")
    }
    
    func testDuration_givenNextTask_shouldReturnDurationBetween() {
        let task = Task(start: Date().at(8, 00), text: "Task 1")
        let nextTask = Task(start: Date().at(10, 00), text: "Task 2")
        
        let duration = task.duration(to: nextTask)
        
        XCTAssertEqual(duration, 2 * 60 * 60, "duration should be 2 hours")
    }
    
    func testDuration_givenAnotherDate_shouldReturnDuration() {
        let task = Task(start: Date().at(8, 00), text: "Task")
        
        let duration = task.duration(to: Date().at(9, 30))
        
        XCTAssertEqual(duration, 90 * 60, "duration should be 90 minutes")
    }
    
    func testDuration_givenAnotherDate_isBeforeTasksStart_shouldReturnZeroDuration() {
        let task = Task(start: Date().at(12, 00), text: "Task")
        
        let duration = task.duration(to: Date().at(11, 00))
        
        XCTAssertEqual(duration, 0, "should not crash nor return a negative duration")
    }
}
