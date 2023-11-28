import SwiftUI
import SwiftData

struct DayView: View {
  @Environment(\.modelContext) var modelContext
  
  @State
  private var date: Date = Date().withoutTime()
  
  @Query
  var days: [Day]
  
  var body: some View {
    @Bindable var day = selectedDay()
    NavigationStack {
      VStack {
        Text(date, style: .date)
          .font(.largeTitle)
        Text(date.asWeekdayString())
          .font(.title2)
        
        if day.tasks.isEmpty {
          EmptyTaskListView(day: day)
        } else {
          TaskListView(day: day)
        }
        DaySummaryView(day: day)
        
        SelectDateView(date: $date)
          .padding([.leading, .bottom, .trailing], 20)
          .padding(.top, 10)
      }
    }
    .tabItem {
      Label("Day", systemImage: "1.circle")
    }
  }
}

extension DayView {
  
  private func selectedDay() -> Day {
    days.first { Calendar.current.isDate($0.date, inSameDayAs: date) } ?? createNewDay()
  }
  
  private func createNewDay() -> Day {
    let newDay = Day(date: date.withoutTime())
    modelContext.insert(newDay)
    return newDay
  }
  
}

#Preview {
  let preview = previewDayModel()
  return TabView {
    DayView()
      .modelContainer(preview.container)
  }
}
