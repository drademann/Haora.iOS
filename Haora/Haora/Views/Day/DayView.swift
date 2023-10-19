import SwiftUI
import SwiftData

struct DayView: View {
    
    @State 
    private var selectedDate: Date = Date().stripTime()
    
    @Query
    var selectedDays: [Day]
    
    var selectedDay: Day {
        get {
            if selectedDays.isEmpty {
                // TODO create new day, insert and return it
                print("should create new task here")
                return Day(date: Date())
            } else {
                print("using exitsing day, yay!")
                return selectedDays.first!
            }
        }
    }
    
    init() {
        let predicate = #Predicate<Day> { $0.date == selectedDate }
        _selectedDays = Query(filter: predicate)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                SelectedDateView(date: selectedDate)
                NonEmptyList
                Summary
                Divider().padding()
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
        }
        .tabItem {
            Label("Day", systemImage: "1.circle")
        }
    }
    
    var NonEmptyList: some View {
        List {
            ForEach(selectedDay.tasks) { _ in
                NavigationLink {} label: { TaskListItemView() }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                        .tint(.green)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive, action: {}) {
                            Image(systemName: "minus")
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.bottom)
    }
    
    var Summary: some View {
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
    
    var EmptyList: some View {
        VStack {
            Spacer()
            Button(action: {}) {
                Label("add first task of the day", systemImage: "plus")
                    .font(.system(size: 20))
            }
            Spacer()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Day.self, configurations: config)
        
        let testDay = Day(date: Date().stripTime())
        testDay.tasks.append(Task(text: "Test Task"))
        container.mainContext.insert(testDay)
        
        return DayView()
            .modelContainer(container)
    }
    catch {
        fatalError("unable to create model container for preview")
    }
    
}
