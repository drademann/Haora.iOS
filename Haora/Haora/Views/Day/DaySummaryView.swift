import SwiftUI
import SwiftData
import TipKit

struct DaySummaryView: View {
    @Environment(\.time) var time
    
    var day: Day
    
    @State private var showDetails = false
    
    private let tapTip = TapTip()
    
    var body: some View {
        TipView(tapTip, arrowEdge: .bottom).padding([.leading, .trailing])
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
                    if showDetails {
                        DetailsView
                    }
                }
                .padding(.horizontal, 20)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if !day.tags().isEmpty {
                    withAnimation(.smooth) { showDetails.toggle() }
                }
            }
        }
    }
    
    private var TotalView: some View {
        HStack {
            Text("total"); Spacer(); Text(day.duration(using: time).asString())
        }
    }
    
    private var BreaksView: some View {
        HStack {
            Text("breaks"); Spacer(); Text(day.durationBreaks(using: time).asString())
        }
    }
    
    private var WorkingView: some View {
        HStack {
            Text("working"); Spacer(); Text(day.durationWorking(using: time).asString())
        }
    }
    
    private var DetailsView: some View {
        let tagTimes = day.tagTimes(using: time)
        return VStack {
            Divider()
            ForEach(day.tags(), id: \.self) { tag in
                HStack {
                    Text("#\(tag.name)"); Spacer(); Text(tagTimes[tag.name]?.asString() ?? "N/A")
                }
            }
        }
    }
}

struct TapTip: Tip {
    var title: Text {
        Text("Tap")
    }
    
    var message: Text? {
        Text("Tap summary to open details with durations per tag.")
    }
    
    var image: Image? {
        Image(systemName: "hand.tap")
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
