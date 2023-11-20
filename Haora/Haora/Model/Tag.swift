import Foundation
import SwiftData

@Model
final class Tag {
    var name: String
    @Relationship(inverse: \Task.tags) var tasks: [Task] = []
    
    init(_ name: String, tasks: [Task] = []) {
        self.name = name
    }
}
