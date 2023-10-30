import SwiftUI

struct EmptyTaskListView: View {
    
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
    EmptyTaskListView()
}
