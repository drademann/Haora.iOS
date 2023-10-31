import SwiftUI

struct SelectDateView: View {
    
    @Binding var date: Date
    
    var body: some View {
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
    }
}

#Preview {
    SelectDateView(date: .constant(Date().withoutTime()))
}
