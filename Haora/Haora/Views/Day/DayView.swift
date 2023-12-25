import SwiftUI
import SwiftData

struct DayView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var date: Date = Date().withoutTime()
    @State private var path = NavigationPath()
    
    @Query
    var days: [Day]
    
    var body: some View {
        @Bindable var day = selectedDay()
        NavigationStack(path: $path) {
            VStack {
                Text(date, style: .date)
                    .font(.largeTitle)
                Text(date.asWeekdayString())
                    .font(.title2)
                
                TaskListView(day: day)
                
                HStack {
                    Spacer()
                    Button(action: { createTask(for: day) }) { Label("new task", systemImage: "plus") }
                        .padding(.trailing, 4)
                }
                .padding(.trailing)
                DaySummaryView(day: day)
                
                SelectDateView(date: $date)
                    .padding([.leading, .bottom, .trailing], 20)
                    .padding(.top, 10)
            }
            .navigationDestination(for: Task.self) { task in TaskView(task: task) }
        }
        .tabItem {
            Label("Day", systemImage: "1.circle")
        }
    }
}

extension DayView {
    
    private func selectedDay() -> Day {
        days.first { Calendar.current.isDate($0.date, inSameDayAs: date) } ?? createDay()
    }
    
    private func createDay() -> Day {
        let newDay = Day(date: date.withoutTime())
        modelContext.insert(newDay)
        return newDay
    }
    
    private func createTask(for day: Day) {
        let task = Task(start: Date.now, text: "New")
        day.tasks.append(task)
        path.append(task)
    }
}

#Preview {
    let preview = previewDayModel()
    return TabView {
        DayView()
            .modelContainer(preview.container)
    }
}
