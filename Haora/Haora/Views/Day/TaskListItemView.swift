import SwiftUI
import SwiftData

struct TaskListItemView: View {
    
    var task: Task
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.text)
                        .foregroundStyle(taskTextForegroundStyle)
                    Text(formatted(task.tags))
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(start) - \(end)")
                    Text(duration)
                }
            }
        }
    }
    
    private var taskTextForegroundStyle: Color { get {
        return if task.isBreak { .green } else { .primary }
    }}
    
    private var start: String { get {
        return task.start.asTimeString()
    }}
    
    private var end: String { get {
        return task.successor()?.start.asTimeString() ?? "now"
    }}
    
    private var duration: String { get {
        return task.duration(to: task.successor())?.asString()
        ?? task.duration(to: Date()).asString()
    }}
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
