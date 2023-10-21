import Foundation
import SwiftData

@Model
final class Task {
    var day: Day?
    var start: Date
    var text: String
    var isPause: Bool
    var tags: [String]
    
    init(start: Date = Date(), text: String, isPause: Bool = false, tags: [String] = []) {
        self.day = nil
        self.start = start
        self.text = text
        self.isPause = isPause
        self.tags = tags
    }
}
