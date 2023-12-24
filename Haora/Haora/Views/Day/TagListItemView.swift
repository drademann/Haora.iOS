import SwiftUI

struct TagListItemView: View {
    
    @Bindable var tag: Tag
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let tag = Tag("Haora")
    return TagListItemView(tag: tag)
}
