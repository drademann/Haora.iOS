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

#Preview("with tasks") {
    ContentView()
        .modelContainer(previewDayModel().container)
}

#Preview("no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return ContentView()
        .modelContainer(preview.container)
}
