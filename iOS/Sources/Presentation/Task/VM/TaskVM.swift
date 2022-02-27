import Combine
import Service
import Foundation
import SwiftUI

final class TaskVM: ObservableObject {
    // MARK: - Properties
    @Published var tasks: [BTask] = [
        .init(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: Date()),
        .init(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 16416_56822)),
        .init(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSinceNow: 8200)),
        .init(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 16416_41927)),
        .init(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 16416_56822)),
        .init(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: Date()),
        .init(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 16416_56822)),
        .init(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 16416_29381))
    ]
    @Published var currentWeek: [Date] = []
    
    @Published var currentDate = Date()
    
    @Published var filteredTasks: [BTask]?
    
    // MARK: - Init
    init() {
        fetchCurrentWeek()
    }
    
    // MARK: - Method
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "UTC")!
            
            let filtered = self.tasks.filter{ calendar.isDate($0.taskDate, inSameDayAs: self.currentDate) }.sorted { $0.taskDate < $1.taskDate }
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
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
    
    func isCurrentDate(_ date: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar.isDate(date, inSameDayAs: currentDate)
    }
    func isCurrentHour(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        return hour == currentHour
    }
}
