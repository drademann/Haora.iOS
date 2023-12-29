import SwiftUI

struct SelectDateView: View {
    
    @Binding var date: Date
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: { switchDay(to: .previous) }) {
                    Label("previous day", systemImage: "chevron.left")
                }
                Spacer()
                Button(action: { switchDay(to: .next) }) {
                    Label("next day", systemImage: "chevron.right")
                        .labelStyle(TrailingImageLabelStyle())
                }
            }
            HStack {
                Spacer()
                Button(action: { switchDay(to: .today) }) {
                    Text("today")
                }
                .disabled(Calendar.current.isDateInToday(date))
                Spacer()
            }
        }
    }
}

extension SelectDateView {
    
    enum Direction {
        case previous
        case today
        case next
    }
    
    private func switchDay(to direction: Direction) {
        switch (direction) {
            case .previous:
                self.date = self.date.previousDay()
            case .today:
                self.date = today()
            case .next:
                self.date = self.date.nextDay()
        }
    }
}

#Preview {
    SelectDateView(date: .constant(today()))
}
