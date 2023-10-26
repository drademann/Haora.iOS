import Foundation

extension TimeInterval {
    
    func formatted() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute ]
        return formatter.string(from: self) ?? "N/A"
    }
}
