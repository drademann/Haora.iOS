import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @Bindable var day: Day
    
    var body: some View {
        if day.tasks.isEmpty {
            EmptyList
        } else {
            TaskList
        }
    }
    
    private var TaskList: some View {
        List {
            ForEach(sortedTasks) { task in
                NavigationLink(value: task, label: { TaskListItemView(task: task) })
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive, action: { delete(task) })
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.bottom)
    }
    
    private var sortedTasks: [Task] { get {
        return day.tasks.sorted { $0.start < $1.start }
    }}
    
    private func delete(_ task: Task) {
        day.tasks.removeAll { $0 == task }
    }
    
    private var EmptyList: some View {
        VStack {
            Spacer()
            Text("no tasks yet")
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview("with tasks") {
    let preview = previewDayModel()
    return NavigationStack {
        TaskListView(day: preview.day)
            .modelContainer(preview.container)
    }
}

#Preview("empty") {
    let preview = previewDayModel()
    preview.day.tasks.removeAll()
    return NavigationStack {
        TaskListView(day: preview.day)
            .modelContainer(preview.container)
    }
}
