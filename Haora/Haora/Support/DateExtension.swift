import Foundation

fileprivate let minutes = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]

func now() -> Date {
    let date = Date.now.asTime()
    let dateMinutes = Calendar.current.component(.minute, from: date)
    guard let closestMinute = Dictionary(grouping: minutes, by: { abs($0 - dateMinutes) })
        .sorted(by: { $0.key < $1.key })
        .first?.value.first else {
        fatalError("no nearest minute found for \(date)")
    }
    var components = Calendar.current.dateComponents([.day, .month, .year, .hour], from: date)
    components.minute = closestMinute
    guard let now = Calendar.current.date(from: components) else { fatalError("unable to construct date from \(components)") }
    return now
}

func today() -> Date {
    return Date.now.asDay()
}

extension Date {
    
    func at(_ hour: Int, _ minute: Int) -> Date {
        guard let dateWithTime = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) else {
            fatalError("unable to set hour \(hour) and minute \(minute) on \(self)")
        }
        return dateWithTime
    }
     
    func asTime() -> Date {
        guard let truncated = Calendar.current.nextDate(after: self, matching: DateComponents(second: 0), matchingPolicy: .nextTime, direction: .backward) else {
            fatalError("unable to create date truncated to minutes")
        }
        return truncated
    }
    
    func asDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func previousDay() -> Date {
        let previous = self + DateComponents(day: -1)
        return previous.asDay()
    }
    
    func nextDay() -> Date {
        let next = self + DateComponents(day: 1)
        return next.asDay()
    }
    
    static func +(date: Date, components: DateComponents) -> Date {
        guard let result = Calendar.current.date(byAdding: components, to: date) else {
            fatalError("unable to add \(components) to \(date)")
        }
        return result
    }
}

extension Date {
    
    private static let TimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    func asTimeString() -> String {
        let timeString = Self.TimeFormatter.string(from: self)
        return if timeString.hasPrefix("0") {
            String(timeString.dropFirst())
        } else {
            timeString
        }
    }
    
    static let WeekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    func asWeekdayString() -> String {
        return Self.WeekdayFormatter.string(from: self)
    }
    
}
