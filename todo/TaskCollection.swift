//
//  TaskCollection.swift
//  todo
//
//  Created by 駿河優輝長 on 2019/09/21.
//  Copyright © 2019 Jun Takahashi. All rights reserved.
//

import Foundation

protocol TaskCollectionDelegate: class{
    func reload()
}

class TaskCollection {
    static var shared = TaskCollection()
    
    public private(set) var tasks: [Task] = []
    
    weak var delegate: TaskCollectionDelegate?
    
    let userDefaults = UserDefaults.standard
    
    private init(){
        self.load()
    }
    
    func addTask (_ task: Task) {
        print("😃タスク呼ばれた")
        tasks.append(task)
        self.save()
    }
    
    func editTask() {
        print("😃editTask呼ばれた")
        self.save()
    }
    
//    func save() {
//        self.delegate?.reload()
//    }
    
    func removeTask (_ at: Int) {
        tasks.remove(at: at)
        self.save()
    }
    
    private func save() {
        do {
            let data = try PropertyListEncoder().encode(tasks)
            userDefaults.set(data, forKey: "tasks")
        } catch {
            fatalError("Save Failed.")
        }
        // これ呼ばないと一覧にセーブしたタスクが表示されない
        delegate?.reload()
    }
    
    private func load() {
        guard let data = userDefaults.data(forKey: "tasks") else { return }
        
        do {
            let tasks = try PropertyListDecoder().decode([Task].self, from: data)
            self.tasks = tasks
        } catch {
            fatalError("Cannot Load.")
        }
        
    }

}
