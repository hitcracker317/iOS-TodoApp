//
//  ViewController.swift
//  TodoApp
//
//  Created by MaedaAkira on 2017/06/08.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoArray = [Todo]()
    
    @IBOutlet weak var todoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        if let savedTodo = ud.object(forKey: "todo") as? Data{
            if let unachiveSavedTodo = NSKeyedUnarchiver.unarchiveObject(with: savedTodo) as? [Todo] {
                print("保存内容：\(unachiveSavedTodo)")
                todoArray.append(contentsOf: unachiveSavedTodo)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addTodo(_ sender: Any) {
        //todo追加するアラート
        let alert = UIAlertController(title: "やることリスト", message: "やることを追加してください", preferredStyle: UIAlertControllerStyle.alert)
        
        //テキストエリア追加
        alert.addTextField(configurationHandler: nil)
        
        //OKボタンを追加
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
            if let textField = alert.textFields?.first {
                //データを追加
                self.addTodo(todoText: textField.text!)
            }
        })
        alert.addAction(okButton)
        
        //cancelボタン追加
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelButton)
        
        //アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セクションと行に対応したセルを返す
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) //storyboardで定義したテーブルセルの識別子を参照
        let todo = todoArray[indexPath.row] as! Todo
        cell.textLabel?.text = todo.todoText
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.orange
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューの行数を返す
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 64
    }
    
    //データの操作
    func addTodo(todoText:String) {
        //追加
        let todoData = Todo()
        todoData.todoText = todoText
        todoData.isChecked = false
        
        self.todoArray.insert(todoData, at: 0)
        
        
        let ud = UserDefaults.standard
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: self.todoArray)
        ud.set(archiveData, forKey: "todo")
        
        //テーブルに行を追加
        self.todoTableView.insertRows(at: [IndexPath(row: 0, section:0)], with: UITableViewRowAnimation.right)
    }
    
}

