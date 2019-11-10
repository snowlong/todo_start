//
//  TaskListTableViewController.swift
//  todo
//
//  Created by Jun Takahashi on 2019/05/22.
//  Copyright © 2019年 Jun Takahashi. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController{
    let taskCollection = TaskCollection.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskCollection.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTouchAddButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showToAddViewController", sender: nil)
    }

}

extension TaskListTableViewController: TaskCollectionDelegate {
    func reload() {
        self.tableView.reloadData()
    }
}

extension TaskListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskCollection.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print ("Section: " + String(indexPath.section) + " row:" + String(indexPath.row))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = taskCollection.tasks[indexPath.row].title

        return cell
    }
    
    // 編集できるようにする
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // タスク削除
        taskCollection.removeTask(indexPath.row)
    }
    
    // セルの選択
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        //AddVCに値を渡して編集できるようにする
        let addVC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        addVC.selectedTask = taskCollection.tasks[indexPath.row]
        self.navigationController?.pushViewController(addVC, animated: true)
        
        
    }
    
}
