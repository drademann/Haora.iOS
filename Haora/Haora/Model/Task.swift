import Foundation
import SwiftData

// MARK: - Data

@Model
final class Task {
    var day: Day?
    var start: Date
    var text: String
    var isPause: Bool
    var tags: [Tag] = []
    
    init(day: Day? = nil, start: Date = Date(), text: String, isPause: Bool = false, tags: [Tag] = []) {
        self.day = day
        self.start = start
        self.text = text
        self.isPause = isPause
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
    
    func duration(to next: Task?) -> TimeInterval? {
        guard let next = next else { return nil }
        return DateInterval(start: self.start, end: next.start).duration
    }
    
    func duration(to date: Date = Date()) -> TimeInterval {
        return DateInterval(start: self.start, end: date).duration
    }
}
