import SwiftUI

struct FinishTimePopoverView: View {
    @Environment(\.time) var time
    @Environment(\.dismiss) var dismiss
    
    @Bindable var day: Day
    
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "stop.circle").font(.system(size: 40)).foregroundStyle(.accent)
                Text("Finish Work").font(.headline)
                Spacer()
            }
            .padding(.top)
            HStack {
                Spacer()
                Text("at")
                TimePicker(date: $selectedDate)
            }
            HStack {
                Button(action: setOpen ) { Text("reset") }
                Spacer()
                Button(action: setNow) { Text("now") }
                    .disabled(!day.isToday)
            }
            .padding([.top, .leading, .trailing])
        }
        .onAppear {
            selectedDate = day.finished ?? day.proposeFinish(by: time)
        }
        .onChange(of: selectedDate) {
            day.finished = selectedDate
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
