import Foundation
import SwiftData

@Model
final class Tag {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
