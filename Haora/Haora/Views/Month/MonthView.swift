import SwiftUI

struct MonthView: View {

    var body: some View {
        NavigationView {
            Text("month view")
        }
        .tabItem {
            Label("Month", systemImage: "31.circle")
        }
    }
}

#Preview {
    MonthView()
}
