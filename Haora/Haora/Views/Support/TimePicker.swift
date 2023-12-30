import SwiftUI

struct TimePicker: View {
    @Environment(\.time) var time
    
    @Binding var date: Date
    
    @State private var hour = 10
    @State private var minute = 30
    
    var body: some View {
        HStack(spacing: 0) {
            Picker("", selection: $hour) {
                ForEach(time.availableHours(), id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 100, maxHeight: 110)
            .onChange(of: hour, updateHour)
            Text(":")
            Picker("", selection: $minute) {
                ForEach(time.availableMinutes(), id: \.self) {
                    let prefix = if $0 < 10 { "0" } else { "" }
                    Text("\(prefix)\($0)")
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 100, maxHeight: 110)
            .onChange(of: minute, updateMinute)
        }
        .onAppear(perform: updateDate)
        .onChange(of: date, updateDate)
    }
}

extension TimePicker {

    private func updateHour() {
        var components = Calendar.current.dateComponents([.day, .month, .year, .minute, .hour], from: self.date)
        components.hour = hour
        guard let newDate = Calendar.current.date(from: components) else { fatalError("unable create date with \(components)") }
        self.date = newDate
    }
    
    private func updateMinute() {
        var components = Calendar.current.dateComponents([.day, .month, .year, .minute, .hour], from: self.date)
        components.minute = minute
        guard let newDate = Calendar.current.date(from: components) else { fatalError("unable to create date with \(components)") }
        self.date = newDate
    }
    
    private func updateDate() {
        self.hour = date.hour
        self.minute = time.round(date).minute
    }
}

#Preview {
    VStack {
        TimePicker(date: .constant(Date().at(9, 02)))
        TimePicker(date: .constant(Date().at(17, 22)))
        TimePicker(date: .constant(Date().at(23, 59)))
    }
}
