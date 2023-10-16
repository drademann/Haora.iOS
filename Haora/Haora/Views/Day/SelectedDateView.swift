import SwiftUI

struct SelectedDateView: View {
    
    var date: Date
    
    var body: some View {
        VStack {
            Text(date, style: .date)
                .font(.largeTitle)
            Text("Sunday")
                .font(.title2)
        }
    }
}

#Preview {
    SelectedDateView(date: Date())
}
