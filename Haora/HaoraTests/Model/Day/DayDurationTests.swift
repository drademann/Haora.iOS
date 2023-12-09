import XCTest
import SwiftData
@testable import Haora

@MainActor
final class DayDurationTests: XCTestCase {
    
    func testTotal_givenNoTasks_shouldReturnZero() {
        let day = Day(date: Date().withoutTime())
        
        XCTAssertEqual(day.duration(), 0)
    }
    
    func testTotal_givenDayIsFinsihed_shouldReturnTotalTime() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let task2 = Task(start: Date().at(12, 00), text: "Task 2")
        day.tasks.append(task2)
        
        day.finished = Date().at(17, 00)
        
        let duration = day.duration()
        
        XCTAssertEqual(duration, 7 * 60 * 60, "duration should be 7 hours returns as TimeInterval (seconds)")
    }
    
    func testTotal_givenDayIsNotFinished_shouldReturnTotalTimeToNow() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let task2 = Task(start: Date().at(12, 00), text: "Task 2")
        day.tasks.append(task2)
    
        let testNow = Date().at(15, 30)
        
        let duration = day.duration(currentDate: testNow)
        
        XCTAssertEqual(duration, 5.5 * 60 * 60, "duration should be 10:00 to 15:30 = 5.5 hours as TimeInterval (seconds)")
    }
}
