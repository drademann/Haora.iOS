import Foundation

extension Date {
    
    func asTimeString() -> String {
        let timeString = formatted(FormatStyle().hour().minute())
        return if timeString.hasPrefix("0") {
            String(timeString.dropFirst())
        } else {
            timeString
        }
    }
    
    func asWeekdayString() -> String {
        return formatted(FormatStyle().weekday(.wide))
    }
}
