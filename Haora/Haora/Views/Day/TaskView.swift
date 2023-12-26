import SwiftUI

struct TaskView: View {
    
    @Bindable var task: Task
    
    enum FocusedField { case text }
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            DatePicker("Starting Time", selection: $task.start, displayedComponents: .hourAndMinute)
            HStack {
                Spacer()
                Button(action: { task.start = now() }) { Text("now") }
                    .padding(.trailing, 8)
            }
            .padding(.bottom, 20)
            HStack {
                Text("Description")
                Spacer()
            }
            TextField("enter text", text: $task.text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .text)
                .lineLimit(5, reservesSpace: true)
                .padding(.bottom, 30)
            HStack {
                Text("Tags")
                Spacer()
                NavigationLink(destination: TagListView(task: task)) { Text("edit") }
                    .padding(.trailing, 8)
            }
            .padding(.bottom, 4)
            HStack {
                Text(asString(task.tags))
                    .foregroundStyle(.secondary)
                    .lineSpacing(5)
                Spacer()
            }
            Spacer()
        }
        .navigationTitle("Task")
        .onAppear { focusedField = .text }
        .padding(20)
    }
}

#Preview {
    let preview = previewDayModel()
    preview.task1.tags.append(contentsOf: [Tag("Swift"), Tag("Apple")])
    return NavigationStack {
        TaskView(task: preview.task1)
    }
}
