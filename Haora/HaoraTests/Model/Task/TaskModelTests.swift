import XCTest
import SwiftData
@testable import Haora

final class TaskModelTests: XCTestCase {
  
  @MainActor func testTaskRelationship_toDay_shouldBeSetBySwiftData() throws {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
    
    let day = Day(date: Date().withoutTime())
    container.mainContext.insert(day)
    let task = Task(text: "Working on project Haora")
    
    day.tasks.append(task)
    
    XCTAssertNotNil(task.day)
  }
  
}
