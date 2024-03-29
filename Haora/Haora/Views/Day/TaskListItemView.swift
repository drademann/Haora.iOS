import SwiftUI
import SwiftData

struct TaskListItemView: View {
    @Environment(\.time) var time
    
    var task: Task
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(taskText)
                        .font(.headline)
                        .foregroundStyle(taskTextForegroundStyle)
                    Text(asString(task.tags))
                        .font(.footnote)
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(start)
                        .foregroundStyle(taskTextForegroundStyle)
                    Text(duration)
                        .foregroundStyle(taskTextForegroundStyle)
                }
            }
        }
    }
}

extension TaskListItemView {
    
    private var taskText: String {
        if task.isBreak && task.text.isEmpty {
            String(localized: "Break")
        } else {
            task.text
        }
    }
    
    private var taskTextForegroundStyle: Color {
        if task.isBreak { .secondary } else { .primary }
    }
    
    private var start: String {
        task.start.asTimeString()
    }
    
    private var duration: String {
        task.duration(to: task.successor(), using: time).asString()
    }
}

#Preview {
    let preview = previewDayModel()
    return VStack {
        TaskListItemView(task: preview.task1)
            .modelContainer(preview.container)
        TaskListItemView(task: preview.pause)
            .modelContainer(preview.container)
        TaskListItemView(task: preview.task2)
            .modelContainer(preview.container)
    }
}
