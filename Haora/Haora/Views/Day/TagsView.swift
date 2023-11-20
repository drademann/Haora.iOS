import SwiftUI

struct TagsView: View {

    @Bindable var task: Task
    
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
                        if task.tags.map(\.name).contains(tag) {
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
    let preview = previewDayModel()
    return NavigationStack {
        TagsView(task: Task(start: Date(), text: "a test task", isPause: false, tags: []))
            .modelContainer(preview.container)
    }
}
