import SwiftUI
import SwiftData

struct DayView: View {
    
    @State
    private var date: Date = Date().withoutTime()
    
    @Query
    var days: [Day]
    
    var body: some View {
        @Bindable var day = days.first { $0.date.withoutTime() == date  } ?? Day(date: date)
        NavigationStack {
            VStack {
                Text(date, style: .date)
                    .font(.largeTitle)
                Text("Sunday")
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
