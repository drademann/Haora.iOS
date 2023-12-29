import SwiftUI

struct TimePicker: View {
    
    @Binding var date: Date
    
    init(date: Binding<Date>) {
        self._date = date
        self._hour = State(wrappedValue: Calendar.current.component(.hour, from: date.wrappedValue))
        self._minute = State(wrappedValue: nearestMinute(to: date.wrappedValue))
    }
    
    @State private var hour = 10
    @State private var minute = 30
    
    private let hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    private let minutes = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    
    var body: some View {
        HStack(spacing: 0) {
            Picker("", selection: $hour) {
                ForEach(hours, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 100, maxHeight: 110)
            .onChange(of: hour, updateHour)
            Text(":")
            Picker("", selection: $minute) {
                ForEach(minutes, id: \.self) {
                    let prefix = if $0 < 10 { "0" } else { "" }
                    Text("\(prefix)\($0)")
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 100, maxHeight: 110)
            .onChange(of: minute, updateMinute)
        }
        .onChange(of: date, updateDate)
    }
}

extension TimePicker {
    
    private func nearestMinute(to date: Date) -> Int {
        let dateMinutes = Calendar.current.component(.minute, from: date)
        guard let closestMinute = Dictionary(grouping: minutes, by: { abs($0 - dateMinutes) })
            .sorted(by: { $0.key < $1.key })
            .first?.value.first else {
            fatalError("no nearest minute found for \(date)")
        }
        return closestMinute
    }

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
        self.hour = Calendar.current.component(.hour, from: date)
        self.minute = nearestMinute(to: date)
    }
}

#Preview {
    VStack {
        TimePicker(date: .constant(Date().at(9, 02)))
        TimePicker(date: .constant(Date().at(17, 22)))
        TimePicker(date: .constant(Date().at(23, 59)))
    }
}
