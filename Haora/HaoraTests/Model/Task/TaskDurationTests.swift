import XCTest
import SwiftData
@testable import Haora

@MainActor
final class TaskDurationTests: XCTestCase {
    
    private let time = TestTime(now: Date.now.at(12, 00))
    private func today() -> Date { time.today() }
    
    func testDuration_givenNextTaskIsNil_shouldReturnDurationToNow() {
        let task = Task(start: Date().at(8, 00), text: "Task")
        
        let duration = task.duration(to: nil, currentDate: Date().at(10, 00))
        
        XCTAssertEqual(duration, 2 * 60 * 60, "duration should be 2 hours")
    }
    
    func testDuration_givenNextTaskIsNil_andTaskStartGreaterNow_shouldReturnZero() {
        let task = Task(start: Date().at(12, 00), text: "Task")
        
        let duration = task.duration(to: nil, currentDate: Date().at(10, 00))
        
        XCTAssertEqual(duration, 0, "duration should be zero cause starting in future")
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
    
    func testDuration_givenTaskIsLast_andDayIsFinished_shouldReturnDurationToFinishTime() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        day.finished = today().at(17, 00)
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let task2 = Task(start: Date().at(12, 00), text: "Task 2")
        day.tasks.append(task2)
        
        let duration = task2.duration(to: task2.successor())
        
        XCTAssertEqual(duration, 5 * 60 * 60, "should return 5 hours, 12:00 to 17:00")
    }
}
