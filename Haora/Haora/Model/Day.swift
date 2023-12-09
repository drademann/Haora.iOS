import Foundation
import SwiftData

@Model
final class Day {
  @Attribute(.unique) var date: Date
  @Relationship(deleteRule: .cascade, inverse: \Task.day) var tasks: [Task]
  var finished: Date?
  
  init(date: Date) {
    self.date = date
    self.tasks = []
    self.finished = nil
  }
  
  var sortedTasks: [Task] {
    get {
      return tasks.sorted { $0.start < $1.start }
    }
  }
}

// MARK: - Duration

extension Day {
    
    func duration(currentDate: Date = Date.now) -> TimeInterval {
        guard let start = sortedTasks.first?.start else { return 0 }
        let end = self.finished ?? currentDate
        return DateInterval(start: start, end: end).duration
    }
}
