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

#Preview("a. with tasks") {
    ContentView()
        .modelContainer(previewDayModel().container)
}

#Preview("b. no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return ContentView()
        .modelContainer(preview.container)
}
