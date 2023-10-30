import SwiftUI
import SwiftData

struct DayView: View {
    
    @State
    private var date: Date = Date().withoutTime()
    
    @Query
    var days: [Day]
    
    var body: some View {
        @Bindable var day = days.first { $0.date.withoutTime() == date  } ?? Day(date: date)
        VStack {
            Text(date, style: .date)
                .font(.largeTitle)
            Text("Sunday")
                .font(.title2)
            
            DayTasksView(day: day)
            
            ZStack {
                HStack {
                    Button(action: {}) {
                        Label("previous day", systemImage: "chevron.left")
                    }
                    Spacer()
                    Button(action: {}) {
                        Label("next day", systemImage: "chevron.right")
                            .labelStyle(TrailingImageLabelStyle())
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("today")
                            .tint(.secondary)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
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
        
        return DayView()
            .modelContainer(container)
    }
    catch {
        fatalError("unable to create model container for preview")
    }
}
