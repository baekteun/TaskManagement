import Combine
import Service
import Foundation

final class TaskVM: ObservableObject {
    // MARK: - Properties
    @Published var tasks: [BTask] = [
        .init(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 16416_41927)),
        .init(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 16416_56822)),
        .init(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 16416_29381)),
        .init(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 16416_41927)),
        .init(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 16416_56822)),
        .init(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 16416_29381)),
        .init(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 16416_56822)),
        .init(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 16416_29381))
    ]
    @Published var currentWeek: [Date] = []
    
    // MARK: - Init
    init() {
        fetchCurrentWeek()
    }
    
    // MARK: - Method
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeek = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeek) {
                currentWeek.append(weekDay)
            }
            
        }
        
    }
}
