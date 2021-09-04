//
//  ResultViewController.swift
//  JankenLiT
//
//  Created by 河村大介 on 2021/08/30.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ResultViewController: UIViewController {
    
    @IBOutlet weak var pastTimeLabel: UILabel!
    
    var pastTime: Int!
    let db = Firestore.firestore()
    let currentuser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pastTimeLabel.text = String(pastTime)
        
        db.collection("game").document().setData(["time": pastTime!, "userId": currentuser?.uid, "email": currentuser?.email!], merge: true) { (_) in
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
