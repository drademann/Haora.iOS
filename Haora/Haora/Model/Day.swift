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
}

extension Day {
    
    var sortedTasks: [Task] {
        get {
            return tasks.sorted { $0.start < $1.start }
        }
    }
    
    var firstTask: Task? {
        return sortedTasks.first
    }
    
    var lastTask: Task? {
        return sortedTasks.last
    }
}

extension Day {
    
    func proposeNextTaskTime(now: Date = now()) -> Date {
        if Calendar.current.isDate(self.date, inSameDayAs: now) {
            return proposeNextTaskTimeForToday(now)
        }
        if let last = lastTask {
            return last.start + DateComponents(minute: 15)
        }
        return self.date.at(9, 00)
    }
    
    private func proposeNextTaskTimeForToday(_ now: Date) -> Date {
        if let last = lastTask {
            if last.start > now {
                return last.start + DateComponents(minute: 15)
            }
        }
        return now
    }
}

extension Day {
    
    func duration(now: Date = now()) -> TimeInterval {
        guard let start = firstTask?.start else { return 0 }
        let end = self.finished ?? now
        return DateInterval(start: start, end: end).duration
    }
    
    func durationBreaks(now: Date = now()) -> TimeInterval {
        return sortedTasks
            .filter { $0.isBreak }
            .reduce(0) { sum, task in
                let next = task.successor()?.start ?? now
                return sum + task.duration(to: next)
            }
    }
    
    func durationWorking(now: Date = now()) -> TimeInterval {
        return duration(now: now) - durationBreaks(now: now)
    }
}
