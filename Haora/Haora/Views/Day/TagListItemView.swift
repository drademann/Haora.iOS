import SwiftUI

struct TagListItemView: View {
    
    @Bindable var tag: Tag
    
    enum FocusedField { case name }
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        if tag.isEditing {
            TextField("tag name", text: $tag.name)
                .focused($focusedField, equals: .name)
                .onAppear { focusedField = .name }
                .onSubmit { tag.isEditing = false }
        } else {
            Text("#\(tag.name)")
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
