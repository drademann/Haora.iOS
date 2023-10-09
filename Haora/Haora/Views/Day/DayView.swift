import SwiftUI

struct DayView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text(Date(), style: .date)
                    Text("Sunday")
                }
                Divider()
                List {
                    ForEach(0..<4) { _ in
                        NavigationLink {} label: { TaskView() }
                    }
                }
                .listStyle(.plain)
                Divider()
                HStack {
                    Text("Total")
                    Spacer()
                    Text("11 h")
                }
                .padding(.vertical)
                .padding(.leading, 20)
                .padding(.trailing, 40)
            }
        }
        .tabItem {
            Label("Day", systemImage: "1.circle")
        }
    }
}

#Preview {
    DayView()
}
