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

#Preview("with tasks (GB)") {
    ContentView()
        .modelContainer(previewDayModel().container)
        .environment(\.locale, Locale(identifier: "en_GB"))
}

#Preview("with tasks (DE)") {
    ContentView()
        .modelContainer(previewDayModel().container)
        .environment(\.locale, Locale(identifier: "de_DE"))
}

#Preview("no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return ContentView()
        .modelContainer(preview.container)
}
