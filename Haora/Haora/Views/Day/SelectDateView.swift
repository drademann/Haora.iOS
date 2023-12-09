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
                Button(action: today) {
                    Text("today")
                        .tint(.secondary)
                }
                Spacer()
            }
        }
    }
    
    enum Direction {
        case next
        case previous
    }
    
    private func today() {
        self.date = Date().withoutTime()
    }
    
    private func switchDay(to direction: Direction) {
        let day = daysToSwitch(into: direction)
        let components = DateComponents(day: day)
        guard let changedDay = Calendar.current.date(byAdding: components, to: self.date) else {
            fatalError("unable to switch from \(date) by \(day) day")
        }
        self.date = changedDay.withoutTime()
    }
    
    private func daysToSwitch(into direction: Direction) -> Int {
        return switch (direction) {
            case .next: 1
            case .previous: -1
        }
    }
}

#Preview {
    SelectDateView(date: .constant(Date().withoutTime()))
}
