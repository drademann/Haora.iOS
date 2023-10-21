import SwiftUI

struct TagsView: View {

    @Binding var task: Task
    
    // query
    private let allTags = ["RMS", "PriMa", "Lufthansa", "Flughafen"]
    
    var body: some View {
        VStack {
            List {
                ForEach(allTags, id: \.self) { tag in
                    HStack {
                        Text("#\(tag)")
                            .foregroundColor(.secondary)
                        Spacer()
                        if task.tags.contains(tag) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Tags")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("add", systemImage: "plus") { }
            }
        }
        .padding()
    }
}

#Preview {
    let date = Date()
    return NavigationStack {
        TagsView(task: .constant(Task(day: Day(date: date.stripTime()), start: Date(), text: "a test task", isPause: false, tags: [ "PriMa" ])))
    }
}
