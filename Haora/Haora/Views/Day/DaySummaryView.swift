import SwiftUI
import SwiftData

struct DaySummaryView: View {
    @Environment(\.time) var time
    
    var day: Day
    
    var body: some View {
        TimelineView(.everyMinute) { _ in
            HStack {
                VStack {
                    HStack {
                        Text("Summary")
                            .font(.caption)
                        Spacer()
                    }
                    TotalView
                    BreaksView
                    WorkingView
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private var TotalView: some View {
        HStack {
            Text("total")
            Spacer()
            Text(day.duration(using: time).asString())
        }
    }
    
    private var BreaksView: some View {
        HStack {
            Text("breaks")
            Spacer()
            Text(day.durationBreaks(using: time).asString())
        }
    }
    
    private var WorkingView: some View {
        HStack {
            Text("working")
            Spacer()
            Text(day.durationWorking(using: time).asString())
        }
    }
}

#Preview("open end") {
    let preview = previewDayModel()
    return DaySummaryView(day: preview.day)
        .modelContainer(preview.container)
}

#Preview("finished") {
    let preview = previewDayModel()
    preview.day.finished = Date().at(16, 00)
    return DaySummaryView(day: preview.day)
        .modelContainer(preview.container)
}

#Preview("no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return DaySummaryView(day: preview.day)
        .modelContainer(preview.container)
}
