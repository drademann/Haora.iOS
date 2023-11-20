import SwiftUI
import SwiftData

struct TagsView: View {

    @Bindable var task: Task
    
    @Query
    var tags: [Tag]
    
    var body: some View {
        VStack {
            List {
                ForEach(tags) { tag in
                    HStack {
                        Text("#\(tag.name)")
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
    let preview = previewDayModel()
    return NavigationStack {
        TagsView(task: Task(start: Date(), text: "a test task", isPause: false, tags: []))
            .modelContainer(preview.container)
    }
}
