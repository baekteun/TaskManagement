import Foundation

extension Date {
    func formatString() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEE, m, yyyy"
        return format.string(from: self)
    }
}
