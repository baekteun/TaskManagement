import Foundation

extension Date {
    func extractDate(format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func isToday() -> Bool {
        let cal = Calendar.current
        return cal.isDateInToday(self)
    }
}
