import XCTest
import SwiftData
@testable import Haora

@MainActor
final class TaskNeighbourTests: XCTestCase {
  
  func testSuccessor_givenNoSuccessor_shouldReturnNil() throws {
    let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
    
    let day = Day(date: today())
    container.mainContext.insert(day)
    let task1 = Task(start: Date().at(10, 00), text: "Task 1")
    day.tasks.append(task1)
    let task2 = Task(start: Date().at(12, 00), text: "Task 2")
    day.tasks.append(task2)
    
    let none = task2.successor()
    
    XCTAssertNil(none)
  }
  
  func testSuccessor_shouldReturnAvailableSuccessor() throws {
    let config = ModelConfiguration(for: Day.self, Task.self, isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
    
    let day = Day(date: today())
    container.mainContext.insert(day)
    let task1 = Task(start: Date().at(10, 00), text: "Task 1")
    day.tasks.append(task1)
    let task2 = Task(start: Date().at(12, 00), text: "Task 2")
    day.tasks.append(task2)
    
    let successor = task1.successor()
    
    XCTAssertNotNil(successor)
    XCTAssertEqual(successor, task2)
  }
}
