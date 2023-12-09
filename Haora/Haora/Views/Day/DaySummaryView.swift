import SwiftUI
import SwiftData

struct DaySummaryView: View {
    
    @Bindable var day: Day
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Summary")
                        .font(.caption)
                    Spacer()
                }
                HStack {
                    Text("total")
                    Spacer()
                    Text(day.duration().asString())
                }
                HStack {
                    Text("breaks")
                    Spacer()
                    Text(day.durationBreaks().asString())
                }
                HStack {
                    Text("finished")
                    Spacer()
                    Button(action: {}) {
                        Text("finish work")
                    }
                    Spacer()
                    Text("not yet")
                }
                HStack {
                    Text("working")
                    Spacer()
                    Text(day.durationWorking().asString())
                }
            }
            .padding(.horizontal, 20)
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
