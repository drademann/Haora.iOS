import SwiftUI
import SwiftData

struct TaskListItemView: View {
    
    var task: Task
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.text)
                    Text("#Haora")
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("9:15 - 12:00")
                    Text(duration.formatted())
                }
            }
        }
    }
    
    var duration: TimeInterval { get {
        return task.duration(to: task.successor()) ?? 0.0
    }}
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task = Task(start: Date().at(9, 15), text: "Working on project Haora", isPause: false, tags: ["Haora"])
        day.tasks.append(task)
        let next = Task(start: Date().at(12, 00), text: "Sleeping", isPause: true, tags: [])
        day.tasks.append(next)
        
        return TaskListItemView(task: task)
            .modelContainer(container)
    }
    catch {
        fatalError("unable to create model container for preview")
    }
}
