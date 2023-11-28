import SwiftUI

struct WeekView: View {
  
  var body: some View {
    NavigationView {
      Text("week view")
    }
    .tabItem {
      Label("Week", systemImage: "7.circle")
    }
  }
}

#Preview {
  WeekView()
}
