import SwiftUI
import SwiftData

struct EmptyTaskListView: View {
    
    @Bindable var day: Day
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {}) {
                Label("add first task of the day", systemImage: "plus")
                    .font(.system(size: 20))
            }
            Spacer()
        }
    }
}

#Preview {
    let preview = previewDayModel()
    return EmptyTaskListView(day: preview.day)
        .modelContainer(preview.container)
}
