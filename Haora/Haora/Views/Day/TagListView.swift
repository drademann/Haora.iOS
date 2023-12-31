import SwiftUI
import SwiftData

struct TagListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var task: Task
    
    @Query(sort: \Tag.name)
    var tags: [Tag]
    
    var body: some View {
        Form {
            Section("Tags") {
                List {
                    ForEach(tags) { tag in
                        HStack {
                            TagListItemView(tag: tag)
                                .swipeActions(edge: .leading) {
                                    Button("Edit", action: { tag.isEditing = true })
                                        .tint(.blue)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button("Delete", role: .destructive, action: { delete(tag) })
                                }
                            Spacer()
                            if task.tags.contains(tag) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggle(tag)
                        }
                    }
                }
            }
        }
        .navigationTitle("Tags")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button(action: createTag) { Image(systemName: "plus") }
            }
        }
    }
}

extension TagListView {
    
    private func createTag() {
        let tag = Tag("")
        tag.isEditing = true
        modelContext.insert(tag)
    }
    
    private func delete(_ tag: Tag) {
        modelContext.delete(tag)
    }
    
    private func toggle(_ tag: Tag) {
        if task.tags.contains(tag) {
            guard let indexToDelete = task.tags.firstIndex(of: tag) else { return }
            task.tags.remove(at: indexToDelete)
        } else {
            task.tags.append(tag)
        }
    }
}

#Preview {
    let preview = previewDayModel()
    return NavigationStack {
        TagListView(task: preview.task1)
            .modelContainer(preview.container)
    }
}
