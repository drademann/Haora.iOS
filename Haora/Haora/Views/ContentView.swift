import SwiftUI
import SwiftData

struct ContentView: View {
    
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
        .modelContainer(previewDayModel().container)
}
