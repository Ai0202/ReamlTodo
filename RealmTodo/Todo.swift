//プロジェクトを作成
//Git管理下する
//ライブラリを追加
//UI部品を置く
//線をひっぱる
//コードを書く


import Foundation
import RealmSwift
//データの新規登録、取得、更新、削除

class Todo: Object {
    
    //カラム名を決める
    @objc dynamic var id = Int()
    @objc dynamic var title = String()
    @objc dynamic var date = String()
    
    var list = [NSDictionary]() //tableView表示するために書いてる
    
    //新規登録
    func create(title: String) {
        let realm = try! Realm() //DB接続
        
        //データの書き込み
        try! realm.write {
            
            let todo = Todo()
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            todo.id = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
            todo.title = title
            todo.date = formatter.string(from: now as Date)
            
            realm.add(todo)
        }
    }
    
    //取得
    func getAll() {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let list = realm.objects(Todo.self)
        
        for value in list {
            let todo = ["id": value.id, "title": value.title, "date": value.date] as NSDictionary
            
            self.list.append(todo)
        }
    }
    
    //特定のデータのみ取得
    func getData(id :Int) -> Todo {
        //データベースに接続
        let realm = try! Realm()
        
        //データを取得
        let todo = realm.objects(Todo.self).filter("id = \(id)").first
        
        //取得したデータを返す
        return todo!
    }
    
    //更新
    func update(id: Int, title: String) {
        //DBに接続
        let realm = try! Realm()
        
        //更新するデータを取得する
        let todo = realm.objects(Todo.self).filter("id = \(id)").first
        
        //更新する
        try! realm.write {
            todo!.title = title
        }
    }
    
    //削除
    func delete(id: Int) {
        
        //DBに接続
        let realm = try! Realm()
        
        //削除するデータを取得する
        let todo = realm.objects(Todo.self).filter("id = \(id)").first
        
        //取得したデータを削除する
        try! realm.write {
            realm.delete(todo!)
        }
    }
    
}
