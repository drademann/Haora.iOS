import SwiftUI

struct TaskListView: View {
    
    @Bindable var selectedDay: Day
    
    var body: some View {
        List {
            ForEach(selectedDay.tasks) { task in
                NavigationLink {} label: { TaskListItemView(task: task) }
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
    TaskListView(selectedDay: Day(date: Date()))
}
