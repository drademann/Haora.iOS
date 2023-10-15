import Foundation
import SwiftData

@Model
final class Task {
    var start: Date
    var text: String
    var isPause: Bool
    
    init(start: Date, text: String, isPause: Bool) {
        self.start = start
        self.text = text
        self.isPause = isPause
    }
}
