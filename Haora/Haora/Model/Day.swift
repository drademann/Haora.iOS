import Foundation
import SwiftData

@Model
final class Day {
    var date: Date
    var tasks: [Task]
    var finished: Date?
    
    init(date: Date) {
        self.date = date
        self.tasks = []
        self.finished = nil
    }
}
