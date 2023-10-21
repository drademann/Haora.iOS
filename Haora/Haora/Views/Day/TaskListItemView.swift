import SwiftUI

struct TaskListItemView: View {
    
    var task: Task
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.text)
                    Text("#Haora")
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("9:15 - 12:00")
                    Text("2 h 45 m" )
                }
            }
        }
    }
}

#Preview {
    let date = Date()
    return TaskListItemView(task: Task(day: Day(date: date), start: date, text: "Working on project Haora", isPause: false, tags: ["Haora"]))
}
