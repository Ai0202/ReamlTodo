

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func tapBtn(_ sender: UIButton) {
        
        //navigationControllerを使った時に元の画面に戻る書き方
        self.navigationController?.popViewController(animated: true)
    }


}
