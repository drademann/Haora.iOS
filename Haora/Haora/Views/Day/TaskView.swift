import SwiftUI

struct TaskView: View {
    
    @Bindable var task: Task
    
    var body: some View {
        VStack {
            DatePicker("Starting Time", selection: $task.start, displayedComponents: .hourAndMinute)
            HStack {
                Spacer()
                Button(action: {}) { Text("now") }
                    .padding(.trailing, 8)
            }
            .padding(.bottom, 20)
            HStack {
                Text("Description")
                Spacer()
            }
            TextField("enter text", text: $task.text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5, reservesSpace: true)
                .padding(.bottom, 30)
            HStack {
                Text("Tags")
                Spacer()
                NavigationLink(destination: TagsView(task: task)) { Text("edit") }
                    .padding(.trailing, 8)
            }
            .padding(.bottom, 4)
            HStack {
                Text("#TEST  #GMS  #IMPORTANT  #RMS  #AIRPORT  #LUFTHANSA  #PRIMA")
                    .foregroundStyle(.secondary)
                    .lineSpacing(5)
                Spacer()
            }
            Spacer()
        }
        .navigationTitle("Task")
        .padding(20)
    }
}

#Preview {
    NavigationStack {
        TaskView(task: Task(start: Date(), text: "a test task", isPause: false))
    }
}
