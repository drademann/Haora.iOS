import Foundation
import SwiftData

@MainActor func previewDayModel() -> PreviewDayModel {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task = Task(text: "Working on project Haora")
        day.tasks.append(task)
        
        return PreviewDayModel(container: container, day: day, task: task)
    }
    catch {
        fatalError("unable to create model container for preview due to \(error)")
    }
}

struct PreviewDayModel {
    let container: ModelContainer
    let day: Day
    let task: Task
}
