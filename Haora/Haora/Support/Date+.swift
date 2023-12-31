import Foundation

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
    
    var hour: Int { Calendar.current.component(.hour, from: self) }
    var minute: Int { Calendar.current.component(.minute, from: self) }
    
}
