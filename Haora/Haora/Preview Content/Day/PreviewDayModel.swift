import Foundation
import SwiftData

@MainActor func previewDayModel() -> PreviewDayModel {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, Tag.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task1 = Task(start: Date().at(10, 00), text: "Working on project Haora")
        day.tasks.append(task1)
        let task2 = Task(start: Date().at(12, 00), text: "Cooking")
        day.tasks.append(task2)
        
        let tag1 = Tag("Haora")
        let tag2 = Tag("Question")
        container.mainContext.insert(tag1)
        container.mainContext.insert(tag2)
        
        task1.tags.append(tag1)
        
        return PreviewDayModel(container: container, day: day, task1: task1, task2: task2, tag1: tag1, tag2: tag2)
    }
    catch {
        fatalError("unable to create model container for preview due to \(error)")
    }
}

struct PreviewDayModel {
    let container: ModelContainer
    let day: Day
    let task1: Task
    let task2: Task
    let tag1: Tag
    let tag2: Tag
}
