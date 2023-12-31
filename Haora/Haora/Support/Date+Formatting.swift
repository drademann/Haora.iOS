import Foundation

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
