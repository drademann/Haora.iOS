import SwiftUI
import SwiftData

struct DayView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var date: Date = today()
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
                
                let CreateTaskButton = Button(action: { createTask(for: day) }) { Label("new task", systemImage: "plus") }
                if day.tasks.isEmpty {
                    HStack {
                        Spacer()
                        CreateTaskButton
                        Spacer()
                    }
                    .padding(.bottom, 20)
                } else {
                    HStack {
                        Spacer()
                        CreateTaskButton
                            .padding(.trailing, 4)
                    }
                    .padding(.trailing)
                }
                if !day.tasks.isEmpty {
                    DaySummaryView(day: day)
                }
                
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
        let newDay = Day(date: date.asDay())
        modelContext.insert(newDay)
        return newDay
    }
    
    private func createTask(for day: Day) {
        let task = Task(start: date, text: "") // FIXME select an appropriate time at the currently selected date
        day.tasks.append(task)
        path.append(task)
    }
}

#Preview("a. with tasks") {
    let preview = previewDayModel()
    return TabView {
        DayView()
            .modelContainer(preview.container)
    }
}

#Preview("b. no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return TabView {
        DayView()
            .modelContainer(preview.container)
    }
}
