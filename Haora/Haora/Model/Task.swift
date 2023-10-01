import Foundation
import SwiftData

@Model
final class Task {
    var start: Date
    var text: String
    
    init(start: Date, text: String) {
        self.start = start
        self.text = text
    }
}
