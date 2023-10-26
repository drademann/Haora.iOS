import XCTest
@testable import Haora

final class TaskDurationTests: XCTestCase {
    
    func testDuration_givenNextTaskIsNil_shouldReturnNil() {
        let task = Task(start: Date().at(8, 00), text: "Task")
        
        let duration = task.duration(to: nil)
        
        XCTAssertNil(duration)
    }
    
    func testDuration_givenNextTask_shouldReturnDurationBetween() {
        let task = Task(start: Date().at(8, 00), text: "Task 1")
        let nextTask = Task(start: Date().at(10, 00), text: "Task 2")
        
        let duration = task.duration(to: nextTask)
        
        XCTAssertEqual(duration, 2 * 60 * 60) // seconds
    }
}
