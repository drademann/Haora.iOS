import SwiftUI

struct FinishTimePopoverView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var day: Day
    
    @State private var selectedDate: Date
    
    init(day: Day) {
        self.day = day
        self._selectedDate = State<Date>.init(initialValue: day.finished ?? day.proposeFinishTime())
    }
    
    var body: some View {
        VStack {
            DatePicker("finishing day at", selection: $selectedDate, displayedComponents: .hourAndMinute)
            HStack {
                Button(action: setOpen ) { Text("open") }
                Spacer()
                Button(action: setNow) { Text("now") }
                    .disabled(!day.isToday)
                Spacer()
                Button(action: setSelected) { Text("set") }
            }
            .padding([.top, .leading, .trailing])
        }
    }
}

extension FinishTimePopoverView {
    
    private func setOpen() {
        day.finished = nil
        dismiss()
    }
    
    private func setNow() {
        day.finished = now()
        dismiss()
    }
    
    private func setSelected() {
        day.finished = selectedDate
        dismiss()
    }
}

#Preview {
    let preview = previewDayModel()
    return FinishTimePopoverView(day: preview.day)
}
