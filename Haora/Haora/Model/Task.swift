import Foundation
import SwiftData

@Model
final class Task {
    var start: Date
    var text: String
    var isPause: Bool
    var tags: [String]
    
    init(start: Date = Date(), text: String, isPause: Bool = false, tags: [String] = []) {
        self.start = start
        self.text = text
        self.isPause = isPause
        self.tags = tags
    }
}
