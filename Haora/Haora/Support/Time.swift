import Foundation

class Time {
    
    enum MinuteInterval: Int {
        case one = 1
        case five = 5
        case quarter = 15
        case half = 30
    }
    
    private var interval: MinuteInterval = .five
    
    func now() -> Date {
        return self.round(Date.now.asTime())
    }
    
    func today() -> Date {
        return Date.now.asDay()
    }
    
    func round(_ date: Date) -> Date {
        let dateMinutes = Calendar.current.component(.minute, from: date)
        guard let closestMinute = Dictionary(grouping: availableMinutes(), by: { abs($0 - dateMinutes) })
            .sorted(by: { $0.key < $1.key })
            .first?.value.first else {
            fatalError("no nearest minute found for \(date)")
        }
        var components = Calendar.current.dateComponents([.day, .month, .year, .hour], from: date)
        components.minute = closestMinute
        guard let rounded = Calendar.current.date(from: components) else { fatalError("unable to construct date from \(components)") }
        return rounded
    }
    
    func availableMinutes() -> [Int] {
        return (0...59).filter { $0 % interval.rawValue == 0 }
    }
    
    func availableHours() -> [Int] {
        return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    }
    
    enum Direction {
        case previous
        case today
        case next
    }
    
    func switchDay(of date: Date, to direction: Direction) -> Date {
        return switch (direction) {
            case .previous:
                date.previousDay()
            case .today:
                today()
            case .next:
                date.nextDay()
        }
    }
}
