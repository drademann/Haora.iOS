import SwiftUI
import SwiftData
import OSLog

struct TaskListView: View {
    
    @Bindable var day: Day
    
    @State private var showFinishTimePopover = false
    
    var body: some View {
        TimelineView(.everyMinute) { _ in
            ZStack {
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
                Text(day.date.asWeekdayShortString())
                    .font(.system(size: 180, weight: .bold, design: .rounded))
                    .opacity(0.02)
                    .padding(.top, 50)
            }
        }
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
                            Text("open")
                        } else {
                            Text(day.finished!.asTimeString())
                        }
                    }
                    .popover(isPresented: $showFinishTimePopover, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
                        FinishTimePopoverView(day: day)
                            .presentationDetents([.height(300)])
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
        if day.tasks.isEmpty { day.finished = nil }
    }
}

#Preview {
    let preview = previewDayModel()
    return NavigationStack {
        TaskListView(day: preview.day)
            .modelContainer(preview.container)
    }
}
