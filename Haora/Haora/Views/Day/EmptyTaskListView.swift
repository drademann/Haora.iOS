import SwiftUI
import SwiftData

struct EmptyTaskListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var day: Day
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: { createFirstTask() }) {
                Label("add first task of the day", systemImage: "plus")
                    .font(.system(size: 20))
            }
            Spacer()
        }
    }
    
    private func createFirstTask() {
        let task = Task(start: Date.now, text: "New")
        day.tasks.append(task)
        path.append(task)
    }
}

#Preview {
    let preview = previewDayModel()
    let path = NavigationPath()
    return EmptyTaskListView(day: preview.day, path: .constant(path))
        .modelContainer(preview.container)
}
