import Foundation

// MARK: - Instantiation

extension Date {

    func at(_ hour: Int, _ minute: Int) -> Date {
        guard let dateWithTime = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) else {
            fatalError("unable to set hour \(hour) and minute \(minute) on \(self)")
        }
        return dateWithTime
    }
    
    func withoutTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)!
    }
}

// MARK: - Output

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
