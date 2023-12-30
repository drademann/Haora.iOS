import XCTest
import SwiftData
@testable import Haora

@MainActor
final class DayDurationTests: XCTestCase {
    
    private let time = TestTime(now: Date.now.at(17, 00))
    private func today() -> Date { time.today() }
    
    func testTotal_givenNoTasks_shouldReturnZero() {
        let day = Day(date: today())
        
        XCTAssertEqual(day.duration(by: time), 0)
    }
    
    func testTotal_givenDayIsFinsihed_shouldReturnTotalTime() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let task2 = Task(start: Date().at(12, 00), text: "Task 2")
        day.tasks.append(task2)
        
        day.finished = Date().at(20, 00)
        
        let duration = day.duration(by: time)
        
        XCTAssertEqual(duration, 10 * 60 * 60, "duration should be 10 hours returns as TimeInterval (seconds)")
    }
    
    func testTotal_givenDayIsNotFinished_shouldReturnTotalTimeToNow() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let task2 = Task(start: Date().at(12, 00), text: "Task 2")
        day.tasks.append(task2)
        
        let duration = day.duration(by: time)
        
        XCTAssertEqual(duration, 7 * 60 * 60, "duration should be 10:00 to 17:00 = 7 hours as TimeInterval (seconds)")
    }
    
    func testTotal_givenDayIsNotFinished_andFirstTasksStartGreaterNow_shouldReturnZero() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(18, 00), text: "Task")
        day.tasks.append(task1)
        
        let duration = day.duration(by: time)
        
        XCTAssertEqual(duration, 0, "duration is zero cause first task starts in future")
    }
    
    func testTotalPause_givenNoTasks_shouldReturnZero() {
        let day = Day(date: today())
        
        XCTAssertEqual(day.durationBreaks(by: time), 0)
    }
    
    func testTotalPause_givenSinglePause_shouldReturnDuratioOfIt() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let pause = Task(start: Date().at(12, 00), text: "Pause", isBreak: true)
        day.tasks.append(pause)
        let task2 = Task(start: Date().at(12, 45), text: "Task 2")
        day.tasks.append(task2)
        
        let durationPause = day.durationBreaks(by: time)
        
        XCTAssertEqual(durationPause, 45 * 60, "duration of the pause should be 45 minutes")
    }
    
    func testTotalPause_givenMultiplePause_shouldReturnTheirDurationSum() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
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
        
        let durationPause = day.durationBreaks(by: time)
        
        XCTAssertEqual(durationPause, 1 * 60 * 60, "total duration of pauses should be 1 hour")
    }
    
    func testTotalPause_givenPauseIsOpenEnd_shouldReturnTheirDurationSum_withLastPauseToNow() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Task 1")
        day.tasks.append(task1)
        let pause1 = Task(start: Date().at(12, 00), text: "Pause 1", isBreak: true)
        day.tasks.append(pause1)
        let task2 = Task(start: Date().at(12, 45), text: "Task 2")
        day.tasks.append(task2)
        let pause2 = Task(start: Date().at(15, 00), text: "Pause 2", isBreak: true)
        day.tasks.append(pause2)
        
        let durationPause = day.durationBreaks(by: time)
        
        XCTAssertEqual(durationPause, 2.75 * 60 * 60, "total duration of pauses should be 2 hours and 45 minutes")
    }
    
    func testDurationWorking_givenNoTasks_shouldReturnZero() {
        let day = Day(date: today())
        
        XCTAssertEqual(day.durationWorking(by: time), 0)
    }
    
    func testDurationWorking_shouldReturnResult_ofTotalMinusBreaks() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
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
        
        day.finished = Date().at(17, 00)
        
        let durationWorking = day.durationWorking(by: time)
        
        XCTAssertEqual(durationWorking, 6 * 60 * 60, "total duration of working time should be 6 hour")
    }
}
