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
            //try? Tips.resetDatastore()
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
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
