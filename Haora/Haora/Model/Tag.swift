import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var name: String
    @Relationship(inverse: \Task.tags) var tasks: [Task] = []
    
    init(_ name: String, tasks: [Task] = []) {
        self.name = name
        self.tasks = tasks
    }
    
    var isEditing = false
}

enum TagFormatStyle {
    case spaceSeparated
}

func asString(_ tags: [Tag], style: TagFormatStyle = .spaceSeparated) -> String {
    return tags.sorted(by: { $0.name < $1.name }).map { "#\($0.name)" }.joined(separator: " ")
}
