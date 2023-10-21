import Foundation
import SwiftData

@Model
final class Day {
    @Attribute(.unique) 
    var date: Date
    @Relationship(deleteRule: .cascade, inverse: \Task.day)
    var tasks: [Task]
    var finished: Date?
    
    init(date: Date) {
        self.date = date
        self.tasks = []
        self.finished = nil
    }
}
