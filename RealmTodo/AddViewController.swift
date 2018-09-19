

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btn: UIButton!
    var id = Int()
    
    let todo = Todo()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if id == Int() {
            btn.setTitle("add", for: .normal)
        } else {
            btn.setTitle("update", for: .normal)
            let selectedTodo = todo.getData(id: id)
            textField.text! = selectedTodo.title
        }
    }
    

    @IBAction func tapBtn(_ sender: UIButton) {
        
        //テキストが空だった場合
        if textField.text! == "" {
            //アラートを表示してあげると親切
            return
        }
        
        if id == Int() {
            //新規保存
            todo.create(title: textField.text!)
        } else {
            //更新処理
            todo.update(id: id, title: textField.text!)
        }
        
        //navigationControllerを使った時に元の画面に戻る書き方
        self.navigationController?.popViewController(animated: true)
    }


}
