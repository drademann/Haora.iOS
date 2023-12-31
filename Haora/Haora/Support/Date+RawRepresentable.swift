import Foundation

extension Date: RawRepresentable {
    
    public var rawValue: String {
        return self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        guard let value = Double(rawValue) else { fatalError("unable to create Date from raw value \(rawValue)") }
        self = Date(timeIntervalSinceReferenceDate: value)
    }
}
