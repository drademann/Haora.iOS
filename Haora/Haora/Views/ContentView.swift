import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    
    var body: some View {
        TabView {
            DayView()
            WeekView()
            MonthView()
        }
        .task {
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
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
