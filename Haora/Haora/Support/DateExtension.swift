import Foundation

func now() -> Date {
    return Date.now.asTime()
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
        guard let previous = Calendar.current.date(byAdding: DateComponents(day: -1), to: self) else {
            fatalError("unable to get from \(self) to previous day")
        }
        return previous.asDay()
    }
    
    func nextDay() -> Date {
        guard let next = Calendar.current.date(byAdding: DateComponents(day: 1), to: self) else {
            fatalError("unable to get from \(self) to next day")
        }
        return next.asDay()
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
