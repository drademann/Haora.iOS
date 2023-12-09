import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @Bindable var day: Day
    
    var body: some View {
        List {
            ForEach(sortedTasks) { task in
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
    
    private var sortedTasks: [Task] { get {
        return day.tasks.sorted { $0.start < $1.start }
    }}
}

#Preview {
    let preview = previewDayModel()
    return NavigationStack {
        TaskListView(day: preview.day)
            .modelContainer(preview.container)
    }
}
