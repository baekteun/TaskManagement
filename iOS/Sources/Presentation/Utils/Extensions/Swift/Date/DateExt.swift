import Foundation

extension Date {
    func extractDate(format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "Ko_kr")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
    func isToday() -> Bool {
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "UTC")!
        return cal.isDateInToday(self)
    }
}
