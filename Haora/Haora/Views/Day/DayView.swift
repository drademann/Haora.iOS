import SwiftUI
import SwiftData

struct DayView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.time) var time
    
    @SceneStorage("net.beyondworlds.Haora.selectedDate") private var date: Date = Date()
    @State private var path = NavigationPath()
    
    @Query
    var days: [Day]
    
    var body: some View {
        @Bindable var day = selectedDay()
        NavigationStack(path: $path) {
            VStack {
                if day.tasks.isEmpty {
                    EmptyList(day: day)
                } else {
                    TaskListView(day: day)
                }
                let CreateTaskButton = Button(action: { createTask(for: day) }) { Label("new task", systemImage: "plus") }
                if day.tasks.isEmpty {
                    CreateTaskButton.padding(.bottom, 20)
                } else {
                    HStack { Spacer(); CreateTaskButton }.padding(.trailing, 20)
                }
                if !day.tasks.isEmpty {
                    DaySummaryView(day: day)
                        .padding(.horizontal, 20)
                }
                SelectDateView(date: $date)
                    .padding()
            }
        }
        .tabItem {
            Label("Day", systemImage: "1.circle")
        }
    }
    
    private func EmptyList(day: Day) -> some View {
        ZStack {
            VStack {
                Spacer()
                Text("no tasks yet")
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Text(day.date.asWeekdayShortString())
                .font(.system(size: 180, weight: .bold, design: .rounded))
                .opacity(0.02)
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
        let task = Task(start: day.proposeNextTaskStart(by: time), text: "")
        day.tasks.append(task)
        path.append(task)
    }
}

#Preview("with tasks") {
    let preview = previewDayModel()
    return TabView {
        DayView()
            .modelContainer(preview.container)
    }
}

#Preview("no tasks") {
    let preview = previewDayModel()
    preview.day.tasks = []
    return TabView {
        DayView()
            .modelContainer(preview.container)
    }
}
