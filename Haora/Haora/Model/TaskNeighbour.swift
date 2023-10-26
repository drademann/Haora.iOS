extension Task {
    
    func successor() -> Task? {
        let tasks = day!.sortedTasks
        if let index = tasks.firstIndex(of: self) {
            let successorIndex = tasks.index(after: index)
            if successorIndex < tasks.endIndex {
                return tasks[successorIndex]
            }
        }
        return nil
    }
}
