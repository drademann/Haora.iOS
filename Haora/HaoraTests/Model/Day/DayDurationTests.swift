import XCTest
import SwiftData
@testable import Haora

@MainActor
final class DayDurationTests: XCTestCase {
    
    // MARK: - total time
    
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
    
    // MARK: - total pause time
    
    func testTotalPause_givenNoTasks_shouldReturnZero() {
        let day = Day(date: Date().withoutTime())
        
        XCTAssertEqual(day.durationBreaks(), 0)
    }
    
    func testTotalPause_givenSinglePause_shouldReturnDuratioOfIt() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let pause = Task(start: Date().at(12, 00), text: "Pause", isBreak: true)
        day.tasks.append(pause)
        let task2 = Task(start: Date().at(12, 45), text: "Task 2")
        day.tasks.append(task2)
        
        let durationPause = day.durationBreaks()
        
        XCTAssertEqual(durationPause, 45 * 60, "duration of the pause should be 45 minutes")
    }
    
    func testTotalPause_givenMultiplePause_shouldReturnTheirDurationSum() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let pause1 = Task(start: Date().at(12, 00), text: "Pause 1", isBreak: true)
        day.tasks.append(pause1)
        let task2 = Task(start: Date().at(12, 45), text: "Task 2")
        day.tasks.append(task2)
        let pause2 = Task(start: Date().at(15, 00), text: "Pause 2", isBreak: true)
        day.tasks.append(pause2)
        let task3 = Task(start: Date().at(15, 15), text: "Task 3")
        day.tasks.append(task3)
        
        let durationPause = day.durationBreaks()
        
        XCTAssertEqual(durationPause, 1 * 60 * 60, "total duration of pauses should be 1 hour")
    }
    
    func testTotalPause_givenPauseIsOpenEnd_shouldReturnTheirDurationSum_withLastPauseToNow() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let pause1 = Task(start: Date().at(12, 00), text: "Pause 1", isBreak: true)
        day.tasks.append(pause1)
        let task2 = Task(start: Date().at(12, 45), text: "Task 2")
        day.tasks.append(task2)
        let pause2 = Task(start: Date().at(15, 00), text: "Pause 2", isBreak: true)
        day.tasks.append(pause2)
        
        let testNow = Date().at(17, 00)
        
        let durationPause = day.durationBreaks(currentDate: testNow)
        
        XCTAssertEqual(durationPause, 2.75 * 60 * 60, "total duration of pauses should be 2 hours and 45 minutes")
    }
}
