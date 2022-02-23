import Swinject

extension Container {
    func registerDependency() {
        registerVM()
    }
    
    private func registerVM() {
        self.register(TaskVM.self) { r in
            return TaskVM()
        }
    }
}
