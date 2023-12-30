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
        tasks.sorted { $0.start < $1.start }
    }
    
    var firstTask: Task? {
        sortedTasks.first
    }
    
    var lastTask: Task? {
        sortedTasks.last
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}

extension Day {
    
    func proposeNextTaskStart(by time: Time) -> Date {
        let now = time.now()
        if Calendar.current.isDate(self.date, inSameDayAs: now) {
            return proposeTimeForToday(now)
        }
        if let last = lastTask {
            return last.start + DateComponents(minute: 15)
        }
        return self.date.at(9, 00)
    }
    
    func proposeFinish(by time: Time) -> Date {
        if tasks.isEmpty { fatalError("without a starting task there shall be no finish time") }
        let now = time.now()
        if Calendar.current.isDate(self.date, inSameDayAs: now) {
            return proposeTimeForToday(now)
        }
        return lastTask!.start + DateComponents(minute: 15)
    }
    
    private func proposeTimeForToday(_ now: Date) -> Date {
        if let last = lastTask, last.start > now {
            return lastTask!.start + DateComponents(minute: 15)
        }
        return now
    }
}

extension Day {
    
    func duration(by time: Time) -> TimeInterval {
        guard let start = firstTask?.start else { return 0 }
        let end = self.finished ?? time.now()
        if (start > end) {
            return 0
        } else {
            return DateInterval(start: start, end: end).duration
        }
    }
    
    func durationBreaks(by time: Time) -> TimeInterval {
        return sortedTasks
            .filter { $0.isBreak }
            .reduce(0) { sum, task in
                let next = task.successor()?.start ?? time.now()
                return sum + task.duration(to: next)
            }
    }
    
    func durationWorking(by time: Time) -> TimeInterval {
        return duration(by: time) - durationBreaks(by: time)
    }
}
