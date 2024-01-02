import XCTest
@testable import Haora

import SwiftData

@MainActor
final class DayGroupingTests: XCTestCase {
    
    private let time = TestTime(now: Date.now.at(17, 00))
    private func today() -> Date { time.today() }
    
    func testGroupByTag_givenDayHasNoTasks_shouldReturnEmptyDictionary() {
        let day = Day(date: Date.now.asDay())
        XCTAssertTrue(day.tasks.isEmpty)
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times, [:])
    }
    
    func testGroupByTag_givenTaskWithoutTag_shouldReturnEmptyDictionary() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task", tags: []))
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times, [:])
    }
    
    func testGroupByTag_givenTaskWithTag_shouldReturnMapWithTagByDuration() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task", tags: [Tag("Haora")]))
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times["Haora"], 7.0 * 60 * 60)
    }
    
    func testGroupByTag_givenTasksWithSameTag_shouldReturnMapWithTagByDurationSum() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1", tags: [Tag("Haora")]))
        day.tasks.append(Task(start: today().at(12, 00), text: "Task 2", tags: [Tag("Haora")]))
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times["Haora"], 7.0 * 60 * 60)
    }
    
    func testGroupByTag_givenTasksWithDifferentTags_shouldReturnMapWithTagsByDuration() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1", tags: [Tag("Project A")]))
        day.tasks.append(Task(start: today().at(13, 00), text: "Task 2", tags: [Tag("Project B")]))
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times["Project A"], 3.0 * 60 * 60)
        XCTAssertEqual(times["Project B"], 4.0 * 60 * 60)
    }
    
    func testGroupByTag_givenTasksWithDifferentTags_shouldReturnMapWithTagsByDurationSums() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1", tags: [Tag("Project A")]))
        day.tasks.append(Task(start: today().at(13, 00), text: "Task 2", tags: [Tag("Project B")]))
        day.tasks.append(Task(start: today().at(15, 00), text: "Task 3", tags: [Tag("Project A")]))
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times["Project A"], 5.0 * 60 * 60)
        XCTAssertEqual(times["Project B"], 2.0 * 60 * 60)
    }
    
    func testGroupByTag_givenTasksAndBreaks_shouldNotCountBreaks() throws {
        let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: today())
        container.mainContext.insert(day)
        day.tasks.append(Task(start: today().at(10, 00), text: "Task 1", tags: [Tag("Project A")]))
        day.tasks.append(Task(start: today().at(12, 00), text: "Break", isBreak: true, tags: [Tag("Project A")]))
        day.tasks.append(Task(start: today().at(13, 00), text: "Task 2", tags: [Tag("Project B")]))
        
        let times = day.tagTimes(using: time)
        
        XCTAssertEqual(times["Project A"], 2.0 * 60 * 60)
        XCTAssertEqual(times["Project B"], 4.0 * 60 * 60)
    }
}
