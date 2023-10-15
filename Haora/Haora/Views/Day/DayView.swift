import SwiftUI

struct DayView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text(Date(), style: .date)
                        .font(.largeTitle)
                    Text("Sunday")
                        .font(.title2)
                }
                nonEmptyList
                summary
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
    
    var nonEmptyList: some View {
        List {
            ForEach(0..<4) { _ in
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
    
    var summary: some View {
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
