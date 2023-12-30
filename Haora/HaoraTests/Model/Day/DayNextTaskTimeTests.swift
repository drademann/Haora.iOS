import XCTest
import SwiftData
@testable import Haora

@MainActor
final class DayNextTaskTimeTests: XCTestCase {
    
    private let time = TestTime(now: Date.now.at(12, 00))
    private func today() -> Date { time.today() }
    
    func testNextTaskTime_givenDayIsToday_andCurrentTimeAfterLastTaskTime_shouldProposeCurrentTimeForNextTask() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task"))
        
        let nextTaskTime = day.proposeNextTaskStart(by: time)
        
        XCTAssertEqual(nextTaskTime, today().at(12, 00), "should use current time as start for next task")
    }
    
    func testNextTaskTime_givenDayIsToday_andCurrentTimeBeforeLastTaskTime_shouldProposeLastTaskTimePlusThreshold() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1"))
        day.tasks.append(Task(start: today().at(13, 00), text: "Task 2"))
        
        let nextTaskTime = day.proposeNextTaskStart(by: time)
        
        XCTAssertEqual(nextTaskTime, today().at(13, 15), "should add 15 minutes threshold to last task's time")
    }
    
    func testNextTaskTime_givenDayIsNotToday_shouldProposeLastTaskTimePlusThreshold() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today().previousDay())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1"))
        day.tasks.append(Task(start: today().at(11, 00), text: "Task 2"))
        
        let nextTaskTime = day.proposeNextTaskStart(by: time)
        
        XCTAssertEqual(nextTaskTime, today().at(11, 15), "should add 15 minutes threshold to last task's time")
    }
    
    func testNextTaskTime_givenDayIsNotToday_andHasNoTasksYet_shouldProposeStandardStart() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today().previousDay())
        container.mainContext.insert(day)
        
        let nextTaskTime = day.proposeNextTaskStart(by: time)
        
        XCTAssertEqual(nextTaskTime, day.date.at(9, 00), "should use fixed start time")
    }
}
