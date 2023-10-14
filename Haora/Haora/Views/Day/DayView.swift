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
                nonEmptyList
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
    
    var nonEmptyList: some View {
        List {
            ForEach(0..<4) { _ in
                NavigationLink {} label: { TaskView() }
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
        }
        .listStyle(.plain)
    }
    
    var emptyList: some View {
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
    DayView()
}
