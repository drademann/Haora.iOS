import Foundation

func now() -> Date {
    guard let now = Calendar.current.nextDate(after: Date.now, matching: DateComponents(second: 0), matchingPolicy: .nextTime, direction: .backward) else {
        fatalError("unable to create 'now' date with seconds set to zero")
    }
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
    
    static let DateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter
    }()
    
    func asTimeString() -> String {
        return Self.DateTimeFormatter.string(from: self)
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
