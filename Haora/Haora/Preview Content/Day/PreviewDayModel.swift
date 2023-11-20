import Foundation
import SwiftData

@MainActor func previewDayModel() -> PreviewDayModel {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, Tag.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task = Task(text: "Working on project Haora")
        day.tasks.append(task)
        
        let tag1 = Tag("Haora")
        let tag2 = Tag("Question")
        container.mainContext.insert(tag1)
        container.mainContext.insert(tag2)
        
        return PreviewDayModel(container: container, day: day, task: task, tag1: tag1, tag2: tag2)
    }
    catch {
        fatalError("unable to create model container for preview due to \(error)")
    }
}

struct PreviewDayModel {
    let container: ModelContainer
    let day: Day
    let task: Task
    let tag1: Tag
    let tag2: Tag
}
