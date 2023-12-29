import XCTest
import SwiftData
@testable import Haora

@MainActor
final class DayFinishTimeTests: XCTestCase {
    
    func testFinishTime_givenDayIsToday_andCurrentTimeAfterLastTaskTime_shouldProposeCurrentTimeForNextTask() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task"))
        
        let finishTime = day.proposeFinishTime(now: today().at(12, 00))
        
        XCTAssertEqual(finishTime, today().at(12, 00))
    }
    
    func testFinishTime_givenDayIsToday_andCurrentTimeBeforeLastTaskTime_shouldProposeLastTaskTimePlusThreshold() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1"))
        day.tasks.append(Task(start: today().at(13, 00), text: "Task 2"))
        
        let finishTime = day.proposeFinishTime(now: today().at(12, 00))
        
        XCTAssertEqual(finishTime, today().at(13, 15), "should add 15 minutes threshold to last task's time")
    }
    
    func testFinishTime_givenDayIsNotToday_shouldProposeLastTaskTimePlusThreshold() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today().previousDay())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1"))
        day.tasks.append(Task(start: today().at(11, 00), text: "Task 2"))
        
        let finishTime = day.proposeFinishTime(now: today().at(12, 00))
        
        XCTAssertEqual(finishTime, today().at(11, 15), "should add 15 minutes threshold to last task's time")
    }
}
