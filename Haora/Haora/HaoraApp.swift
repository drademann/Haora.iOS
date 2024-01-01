import SwiftUI
import SwiftData

@main
struct HaoraApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([ Day.self, Task.self, Tag.self ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("could not create model container: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TimelineView(.everyMinute) { _ in
                ContentView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

private struct TimeKey: EnvironmentKey {
    static let defaultValue: Time = Time()
}
    
extension EnvironmentValues {
    
    var time: Time {
        get { self[TimeKey.self] }
        set { self[TimeKey.self] = newValue }
    }
}
