import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @Bindable var day: Day
    
    var body: some View {
        List {
            ForEach(day.tasks) { task in
                NavigationLink { TaskView(task: task) } label: { TaskListItemView(task: task) }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                        .tint(.green)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive, action: {}) {
                            Image(systemName: "minus")
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.bottom)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task = Task(text: "Working on project Haora")
        day.tasks.append(task)
        
        return NavigationStack {
            TaskListView(day: day)
                .modelContainer(container)
        }
    }
    catch {
        fatalError("unable to create model container for preview")
    }
}
