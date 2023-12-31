import SwiftUI
import SwiftData
import OSLog

struct TaskListView: View {
    
    @Bindable var day: Day
    
    @State private var showFinishTimePopover = false
    
    var body: some View {
        List {
            ForEach(sortedTasks) { task in
                NavigationLink(value: task, label: { TaskListItemView(task: task) })
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive, action: { delete(task) })
                    }
            }
            .listRowSeparator(.hidden)
            FinishedView
                .listRowSeparator(.hidden)
        }
        .navigationDestination(for: Task.self) { task in TaskView(task: task) }
        .listStyle(.plain)
        .padding(.bottom)
    }
    
    private var FinishedView: some View {
        VStack {
            Divider()
            HStack {
                Text("Finished")
                    .font(.headline)
                Spacer()
                if !day.tasks.isEmpty {
                    Button(action: { showFinishTimePopover = true }) {
                        if day.tasks.isEmpty {
                            Text("no tasks to be finished")
                        } else if day.finished == nil {
                            Text("not yet")
                        } else {
                            Text(day.finished!.asTimeString())
                        }
                    }
                    .font(.headline)
                    .popover(isPresented: $showFinishTimePopover, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
                        FinishTimePopoverView(day: day)
                            .presentationDetents([.height(200)])
                            .padding()
                    }
                }
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.tertiary)
                    .font(Font.system(size: 13, weight: .semibold, design: .default))
            }
            .padding(.top, 6)
        }
    }
}

extension TaskListView {
    
    private var sortedTasks: [Task] { get {
        return day.tasks.sorted { $0.start < $1.start }
    }}
    
    private func delete(_ task: Task) {
        guard let indexToDelete = day.tasks.firstIndex(of: task) else { return }
        day.tasks.remove(at: indexToDelete)
    }
}

#Preview("a. with tasks") {
    let preview = previewDayModel()
    return NavigationStack {
        TaskListView(day: preview.day)
            .modelContainer(preview.container)
    }
}

#Preview("b. empty") {
    let preview = previewDayModel()
    preview.day.tasks.removeAll()
    return NavigationStack {
        TaskListView(day: preview.day)
            .modelContainer(preview.container)
    }
}
