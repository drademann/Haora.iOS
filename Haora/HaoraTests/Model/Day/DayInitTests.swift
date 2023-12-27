import XCTest
import SwiftData
@testable import Haora

@MainActor
final class DayInitTests: XCTestCase {
    
    func testNextTaskTime_givenDayIsToday_andCurrentTimeAfterLastTaskTime_shouldProposeCurrentTimeForNextTask() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task"))
        
        let nextTaskTime = day.proposeNextTaskTime(now: today().at(12, 00))
        
        XCTAssertEqual(nextTaskTime, today().at(12, 00))
    }
    
    func testNextTaskTime_givenDayIsToday_andCurrentTimeBeforeLastTaskTime_shouldProposeLastTaskTimePlusFiveMinutes() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1"))
        day.tasks.append(Task(start: today().at(13, 00), text: "Task 2"))
        
        let nextTaskTime = day.proposeNextTaskTime(now: today().at(12, 00))
        
        XCTAssertEqual(nextTaskTime, today().at(13, 15))
    }
    
    func testNextTaskTime_givenDayIsNotToday_shouldProposeLastTaskTimePlusFiveMinutes() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today().previousDay())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1"))
        day.tasks.append(Task(start: today().at(11, 00), text: "Task 2"))
        
        let nextTaskTime = day.proposeNextTaskTime(now: today().at(12, 00))
        
        XCTAssertEqual(nextTaskTime, today().at(11, 15))
    }
    
    func testNextTaskTime_givenDayIsNotToday_andHasNoTasksYet_shouldProposeStandardStart() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today().previousDay())
        container.mainContext.insert(day)
        
        let nextTaskTime = day.proposeNextTaskTime(now: today().at(12, 00))
        
        XCTAssertEqual(nextTaskTime, day.date.at(9, 00))
    }
}
