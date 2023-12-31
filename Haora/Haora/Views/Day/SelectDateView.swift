import SwiftUI

struct SelectDateView: View {
    @Environment(\.time) var time
    
    @Binding var date: Date
    
    var body: some View {
        VStack {
            Text(date, style: .date)
                .font(.headline)
                .padding(.bottom, 4)
            ZStack {
                HStack {
                    Button(action: { date = time.switchDay(of: date, to: .previous) }) {
                        Label("previous day", systemImage: "chevron.left").padding(.leading)
                    }
                    Spacer()
                    Button(action: { date = time.switchDay(of: date, to: .next) }) {
                        Label("next day", systemImage: "chevron.right").padding(.trailing)
                            .labelStyle(TrailingImageLabelStyle())
                    }
                }
                HStack {
                    Spacer()
                    Button(action: { date = time.switchDay(of: date, to: .today) }) {
                        Text("today")
                    }
                    .disabled(Calendar.current.isDateInToday(date))
                    Spacer()
                }
            }
            Text(date.asWeekdayString())
                .font(.headline)
                .padding(.top, 4)
        }
        .padding([.top, .bottom])
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
        )
        .gesture(switchDayGesture)
    }
    
    var switchDayGesture: some Gesture {
        DragGesture().onEnded { value in
            if value.translation.width < 0 {
                date = time.switchDay(of: date, to: .next)
            } else {
                date = time.switchDay(of: date, to: .previous)
            }
        }
    }
}

#Preview {
    let time = Time()
    return SelectDateView(date: .constant(time.today()))
}
