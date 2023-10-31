import SwiftUI
import SwiftData

struct EmptyTaskListView: View {
    
    @Bindable var day: Day
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {}) {
                Label("add first task of the day", systemImage: "plus")
                    .font(.system(size: 20))
            }
            Spacer()
        }
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
        
        return EmptyTaskListView(day: day)
            .modelContainer(container)
    }
    catch {
        fatalError("unable to create model container for preview")
    }
}
