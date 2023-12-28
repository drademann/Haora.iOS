import SwiftUI
import SwiftData

struct TagListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var task: Task
    
    @Query(sort: \Tag.name)
    var tags: [Tag]
    
    var body: some View {
        VStack {
            List {
                ForEach(tags) { tag in
                    HStack {
                        TagListItemView(tag: tag)
                            .swipeActions(edge: .trailing) {
                                Button("Delete", role: .destructive, action: { delete(tag) })
                            }
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
                Button(action: createTag) { Image(systemName: "plus") }
            }
        }
        .padding()
    }
}

extension TagListView {
    
    private func createTag() {
        let tag = Tag("")
        tag.isEditing = true
        modelContext.insert(tag)
        print(tag.isEditing)
    }
    
    private func delete(_ tag: Tag) {
        modelContext.delete(tag)
    }
}

#Preview {
    let preview = previewDayModel()
    return NavigationStack {
        TagListView(task: preview.task1)
            .modelContainer(preview.container)
    }
}
