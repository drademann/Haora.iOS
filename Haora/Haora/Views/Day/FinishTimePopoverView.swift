import SwiftUI

struct FinishTimePopoverView: View {
    @Environment(\.time) var time
    @Environment(\.dismiss) var dismiss
    
    @Bindable var day: Day
    
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        VStack {
            HStack {
                Text("finishing day at")
                Spacer()
                TimePicker(date: $selectedDate)
            }
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
        .onAppear {
            selectedDate = day.finished ?? day.proposeFinish(by: time)
        }
    }
}

extension FinishTimePopoverView {
    
    private func setOpen() {
        day.finished = nil
        dismiss()
    }
    
    private func setNow() {
        day.finished = time.now()
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
