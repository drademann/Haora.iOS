import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            DayView()
            WeekView()
            MonthView()
        }
    }
    
    
}

#Preview {
    ContentView()
}
