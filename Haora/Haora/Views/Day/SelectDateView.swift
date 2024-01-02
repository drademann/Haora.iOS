import SwiftUI
import TipKit

struct SelectDateView: View {
    @Environment(\.time) var time
    
    @Binding var date: Date
    
    @State private var drag = CGSize.zero
    
    private let tip = SwitchTip()
    
    var body: some View {
        TipView(tip, arrowEdge: .bottom).padding(.bottom, -30)
        HStack {
            Image(systemName: "chevron.compact.left").imageScale(.large).padding(.leading)
            Spacer()
            VStack {
                Text(date, style: .date)
                    .font(.system(size: 18))
                    .padding(.bottom, 4)
                Text(date.asWeekdayString())
                    .padding(.top, 4)
            }
            Spacer()
            Image(systemName: "chevron.compact.right").imageScale(.large).padding(.trailing)
        }
        .padding([.top, .bottom])
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.background)
        )
        .gesture(switchDayGesture)
        .gesture(todayGesture)
        .offset(x: drag.width)
        .animation(.bouncy, value: drag)
    }
    
    var switchDayGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                drag = value.translation
            }
            .onEnded { value in
                if value.translation.width < 0 {
                    self.date = time.switchDay(of: date, to: .next)
                } else {
                    self.date = time.switchDay(of: date, to: .previous)
                }
                drag = .zero
            }
    }
    
    var todayGesture: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                self.date = time.switchDay(of: date, to: .today)
            }
    }
}

struct SwitchTip: Tip {
    var title: Text {
        Text("Swipe to move")
    }
    
    var message: Text? {
        Text("To select the previous or the next day, swipe right or left. To get back to today, double-tap.")
    }
    
    var image: Image? {
        Image(systemName: "hand.tap")
    }
}

#Preview {
    let time = Time()
    return SelectDateView(date: .constant(time.today()))
}
