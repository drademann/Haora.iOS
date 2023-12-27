import SwiftUI
import SwiftData

struct DaySummaryView: View {
    
    @Bindable var day: Day
    
    @State private var showFinishTimePopover = false
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Summary")
                        .font(.caption)
                    Spacer()
                }
                TotalView
                BreaksView
                FinishedView
                WorkingView
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var TotalView: some View {
        HStack {
            Text("total")
            Spacer()
            Text(day.duration().asString())
        }
    }
    
    private var BreaksView: some View {
        HStack {
            Text("breaks")
            Spacer()
            Text(day.durationBreaks().asString())
        }
    }
    
    private var FinishedView: some View {
        HStack {
            Text("finished")
            Spacer()
            if !day.tasks.isEmpty {
                let button = if day.finished == nil {
                    Button(action: { showFinishTimePopover = true }) { Text("finish work") }
                } else {
                    Button(action: { showFinishTimePopover = true }) { Text("reopen day") }
                }
                button
                    .popover(isPresented: $showFinishTimePopover, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
                        FinishTimePopoverView(finished: $day.finished)
                            .presentationDetents([.height(120)])
                            .padding()
                    }
            }
            Spacer()
            if day.tasks.isEmpty {
                Text("no tasks to be finished")
            } else if day.finished == nil {
                Text("not yet")
            } else {
                Text(day.finished!.asTimeString())
            }
        }
    }
    
    private var WorkingView: some View {
        HStack {
            Text("working")
            Spacer()
            Text(day.durationWorking().asString())
        }
    }
}

#Preview("a. open end") {
    let preview = previewDayModel()
    return DaySummaryView(day: preview.day)
        .modelContainer(preview.container)
}

#Preview("b. finished") {
    let preview = previewDayModel()
    preview.day.finished = Date().at(16, 00)
    return DaySummaryView(day: preview.day)
        .modelContainer(preview.container)
}

#Preview("c. no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return DaySummaryView(day: preview.day)
        .modelContainer(preview.container)
}
