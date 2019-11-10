//
//  AddViewController.swift
//  todo
//
//  Created by Jun Takahashi on 2019/05/22.
//  Copyright © 2019年 Jun Takahashi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    let taskCollection = TaskCollection.shared
    
    // 選択したタスクがあれば値が格納される
    var selectedTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedTask = self.selectedTask {
            self.title = "編集"
            // TODO 上書きに変更できない
            // 対策:ボタンを2つ用意する https://teratail.com/questions/45098
            self.navigationItem.rightBarButtonItem?.title = "上書き"

            self.titleTextField.text = selectedTask.title
            self.memoTextView.text = selectedTask.memo
        }
        
    }
    
    @IBAction func didTouchSaveButton(_ sender: Any) {
        guard let title = titleTextField.text else {
            return
        }
        if (title.isEmpty) {
            showAlert("タイトルを入力して下さい。")
            return
        }
        
        if let selectedTask = self.selectedTask {
            // 選択されたタスクがある => 編集
            selectedTask.title = title
            selectedTask.memo = memoTextView.text
            
            taskCollection.editTask()
        } else {
            // 選択されたタスクがない => 新規
            let task = Task(title: title)
            let memo = self.memoTextView.text
            task.memo = memo
            
            taskCollection.addTask(task)
        }
        //ここでTaskを保存したい

        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}
