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
          Text("8 h 15 m")
        }
        HStack {
          Text("breaks")
          Spacer()
          Text("45 m")
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
          Text("7 h 30 m")
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

#Preview {
  let preview = previewDayModel()
  return DaySummaryView(day: preview.day)
    .modelContainer(preview.container)
}
