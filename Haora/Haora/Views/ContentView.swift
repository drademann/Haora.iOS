import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Text("This is the content view.")
    }
    
    
}

#Preview {
    ContentView()
}
