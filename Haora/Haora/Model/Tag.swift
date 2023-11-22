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

// MARK: - Output

enum TagFormatStyle {
    case spaceSeparated
}

func formatted(_ tags: [Tag], style: TagFormatStyle = .spaceSeparated) -> String {
    return tags.map { "#\($0.name)" }.joined(separator: " ")
}
