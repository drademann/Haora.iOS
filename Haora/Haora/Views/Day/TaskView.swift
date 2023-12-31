import SwiftUI

struct TaskView: View {
    @Environment(\.time) var time
    
    @Bindable var task: Task
    
    enum FocusedField { case time, text }
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        Form {
            Section("Time") {
                HStack {
                    Text("Starting")
                    Spacer()
                    Button(action: { task.start = time.now() }) { Text("now") }
                        .padding(.trailing, 8)
                    Spacer()
                    TimePicker(date: $task.start)
                        .focused($focusedField, equals: .time)
                }
                Toggle("is break", isOn: $task.isBreak)
            }
            Section("Description") {
                TextField("enter text", text: $task.text, axis: .vertical)
                    .focused($focusedField, equals: .text)
                    .lineLimit(5, reservesSpace: true)
            }
            Section("Tags") {
                NavigationLink(destination: TagListView(task: task)) {
                    Text(asString(task.tags))
                        .foregroundStyle(.secondary)
                        .lineSpacing(5)
                }
            }
        }
        .navigationTitle("Task")
        .onAppear { focusedField = .time }
    }
}

#Preview {
    let preview = previewDayModel()
    preview.task1.tags.append(contentsOf: [Tag("Swift"), Tag("Apple")])
    return NavigationStack {
        TaskView(task: preview.task1)
    }
}
