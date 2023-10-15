import SwiftUI

struct TagsView: View {

    @Binding var task: Task
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<4) { _ in
                    HStack {
                        Text("TAG")
                        Spacer()
                        Image(systemName: "checkmark")
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
    NavigationStack {
        TagsView(task: .constant(Task(start: Date(), text: "a test task", isPause: false)))
    }
}
