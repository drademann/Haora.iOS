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
    let preview = previewDayModel()
    return TaskListItemView(task: preview.task)
        .modelContainer(preview.container)
}
