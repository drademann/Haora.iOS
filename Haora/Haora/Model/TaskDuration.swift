import Foundation

extension Task {
    
    func duration(to other: Task?) -> TimeInterval? {
        guard let other = other else { return nil }
        return DateInterval(start: self.start, end: other.start).duration
    }
}
