import Foundation

public struct BTask: Identifiable {
    public var id = UUID().uuidString
    public var taskTitle: String
    public var taskDescription: String
    public var taskDate: Date
    
    public init(id: String = UUID().uuidString, taskTitle: String, taskDescription: String, taskDate: Date) {
        self.id = id
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskDate = taskDate
    }
}
