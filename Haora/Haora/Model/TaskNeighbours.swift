extension Task {
    
    func successor() -> Task? {
        let tasks = day!.tasks.sorted { $0.start < $1.start }
        if let index = tasks.firstIndex(where: { $0 == self }) {
            let successorIndex = tasks.index(after: index)
            if successorIndex < tasks.endIndex {
                return tasks[successorIndex]
            }
        }
        return nil
    }
}
