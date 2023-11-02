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
                Text(weekday(of: date))
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
    
    private func weekday(of date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, Task.self, configurations: config)
        
        let day = Day(date: Date().withoutTime())
        container.mainContext.insert(day)
        let task = Task(text: "Working on project Haora")
        day.tasks.append(task)
        
        return TabView {
            DayView()
                .modelContainer(container)
        }
    }
    catch {
        fatalError("unable to create model container for preview")
    }
}
