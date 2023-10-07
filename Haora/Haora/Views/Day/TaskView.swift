import SwiftUI

struct TaskView: View {
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Working on project Haora")
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
    TaskView()
}
