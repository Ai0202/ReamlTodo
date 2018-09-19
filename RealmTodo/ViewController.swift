

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let todo = Todo()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //一覧表示
        todo.list.removeAll()
        todo.getAll()
        tableView.reloadData()
        print(todo.list)
        print()
        
    }

    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    //セルの中身を決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = todo.list[indexPath.row]["title"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //databaseから削除するデータを指定するために書いてる
            let id = todo.list[indexPath.row]["id"] as! Int
            todo.delete(id: id)
            
            //画面からtodoを消している
            todo.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = todo.list[indexPath.row]["id"]!
        performSegue(withIdentifier: "Segue", sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            let addVC = segue.destination as! AddViewController
            addVC.id = sender as! Int
        }
    }
}

