import Foundation
import SwiftData

// MARK: - Data

@Model
final class Task {
    var day: Day?
    var start: Date
    var text: String
    var isBreak: Bool
    var tags: [Tag] = []
    
    init(day: Day? = nil, start: Date = Date(), text: String, isBreak: Bool = false, tags: [Tag] = []) {
        self.day = day
        self.start = start
        self.text = text
        self.isBreak = isBreak
        self.tags = tags
    }
}

// MARK: - Neighbours

extension Task {
    
    func successor() -> Task? {
        let tasks = day!.sortedTasks
        if let index = tasks.firstIndex(of: self) {
            let successorIndex = tasks.index(after: index)
            if successorIndex < tasks.endIndex {
                return tasks[successorIndex]
            }
        }
        return nil
    }
}

// MARK: - Duration

extension Task {
    
    func duration(to next: Task?, currentDate: Date = Date.now) -> TimeInterval {
        guard let next = next else { return duration(to: currentDate) }
        return duration(to: next.start)
    }
    
    func duration(to date: Date) -> TimeInterval {
        if date < self.start { return 0 }
        return DateInterval(start: self.start, end: date).duration
    }
}
