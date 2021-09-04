//
//  LoginViewController.swift
//  JankenLiT
//
//  Created by 河村大介 on 2021/08/30.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func login(_ sender: Any) {
        if let email = loginEmailTextField.text,
           let password = loginPasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if (authResult?.user) != nil {
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                } else if error != nil {
                    let dialog = UIAlertController(title: "ログイン失敗", message: "ログインに失敗しました。", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dialog, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func toSignUp(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    
}
