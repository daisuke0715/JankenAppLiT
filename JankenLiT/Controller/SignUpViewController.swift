//
//  SignUpViewController.swift
//  JankenLiT
//
//  Created by 河村大介 on 2021/08/30.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signup(_ sender: Any) {
        if let email = registerEmailTextField.text,
           let password = registerPasswordTextField.text,
           let name = registerNameTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in })
                if let user = authResult?.user {
                    Firestore.firestore().collection("users").document(user.uid).setData(["userid": user.uid, "mail": email ,"name": name, "time": 0], merge: true) { [self] (error) in
                        if error != nil {
                            let dialog = UIAlertController(title: "新規登録失敗", message: "新規登録に失敗しました。入力情報を確認してください。", preferredStyle: .alert)
                            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(dialog, animated: true, completion: nil)
                        } else {
                            self.performSegue(withIdentifier: "toHome", sender: nil)
                        }
                    }
                } else if error != nil {
                    let dialog = UIAlertController(title: "新規登録失敗", message: "新規登録に失敗しました。入力情報を確認してください。", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dialog, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @IBAction func toLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
