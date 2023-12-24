import SwiftUI

struct TagListItemView: View {
    
    @Bindable var tag: Tag
    
    @State private var isEditing = false
    
    enum FocusedField { case name }
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        if isEditing {
            TextField("tag name", text: $tag.name)
                .focused($focusedField, equals: .name)
                .onAppear { focusedField = .name }
                .onSubmit { isEditing = false }
        } else {
            Text("#\(tag.name)")
                .swipeActions(edge: .leading) {
                    Button("Edit", action: { isEditing = true })
                        .tint(.blue)
                }
        }
    }
}

#Preview {
    let tag = Tag("Haora")
    return List {
        TagListItemView(tag: tag)
    }
    .listStyle(.plain)
}
