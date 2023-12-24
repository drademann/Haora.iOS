import SwiftUI
import SwiftData

struct TagListView: View {
    
    @Bindable var task: Task
    
    @Query(sort: \Tag.name)
    var tags: [Tag]
    
    var body: some View {
        VStack {
            List {
                ForEach(tags) { tag in
                    HStack {
                        TagListItemView(tag: tag)
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
                Button(action: {}) { Image(systemName: "plus") }
            }
        }
        .padding()
    }
}

#Preview {
    let preview = previewDayModel()
    return NavigationStack {
        TagListView(task: preview.task1)
            .modelContainer(preview.container)
    }
}
