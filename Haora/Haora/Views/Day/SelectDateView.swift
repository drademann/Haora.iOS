import SwiftUI

struct SelectDateView: View {
    
    @Binding var date: Date
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: { switchDay(day: -1) }) {
                    Label("previous day", systemImage: "chevron.left")
                }
                Spacer()
                Button(action: { switchDay(day: +1) }) {
                    Label("next day", systemImage: "chevron.right")
                        .labelStyle(TrailingImageLabelStyle())
                }
            }
            HStack {
                Spacer()
                Button(action: today) {
                    Text("today")
                        .tint(.secondary)
                }
                Spacer()
            }
        }
    }
    
    private func switchDay(day: Int) {
        let components = DateComponents(day: day)
        guard let changedDay = Calendar.current.date(byAdding: components, to: self.date) else {
            fatalError("unable to switch from \(date) by \(day) day")
        }
        self.date = changedDay.withoutTime()
    }
    
    private func today() {
        self.date = Date().withoutTime()
    }
}

#Preview {
    SelectDateView(date: .constant(Date().withoutTime()))
}
