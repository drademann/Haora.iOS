import SwiftUI

struct FinishTimePopoverView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var finished: Date?
    
    @State private var selectedDate: Date
    
    init(finished: Binding<Date?>) {
        self._finished = finished
        self._selectedDate = State<Date>.init(initialValue: finished.wrappedValue ?? now()) // FIXME needs a proposed time instead of 'now()'
    }
    
    var body: some View {
        VStack {
            DatePicker("finishing day at", selection: $selectedDate, displayedComponents: .hourAndMinute)
            HStack {
                Button(action: setOpen ) { Text("open") }
                Spacer()
                Button(action: setNow) { Text("now") }
                Spacer()
                Button(action: setSelected) { Text("set") }
            }
            .padding([.top, .leading, .trailing])
        }
    }
}

extension FinishTimePopoverView {
    
    private func setOpen() {
        finished = nil
        dismiss()
    }
    
    private func setNow() {
        finished = now()
        dismiss()
    }
    
    private func setSelected() {
        finished = selectedDate
        dismiss()
    }
}

#Preview {
    let preview = previewDayModel()
    return FinishTimePopoverView(finished: .constant(preview.day.finished))
}
