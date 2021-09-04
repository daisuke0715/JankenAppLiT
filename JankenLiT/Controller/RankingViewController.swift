//
//  RankingViewController.swift
//  JankenLiT
//
//  Created by 河村大介 on 2021/08/30.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var userData = [UserData]()
    let userCollection = Firestore.firestore().collection("game")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userData = getData()
    }
    
    func getData() -> [UserData] {
        let ref = userCollection.order(by: "time", descending: true)
        
        ref.getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.userData = (snapshot?.documents.map({ (document) -> UserData in
                let data = UserData(document: document)
                return data
            }))!
            self.tableView.reloadData()
        }
        
        return userData
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let rankLabel = cell?.contentView.viewWithTag(1) as! UILabel
        let userNameLabel =  cell?.contentView.viewWithTag(2) as! UILabel
        
        rankLabel.text = String(indexPath.row + 1)
        userNameLabel.text = userData[indexPath.row].mail
        
        return  cell!
    }
    

}


class UserData: NSObject {
    var uid: String?
    var name: String?
    var time: Int?
    var mail: String?
    
    init(document: QueryDocumentSnapshot) {
        self.uid = document.documentID
        let dic = document.data()
        self.name = dic["name"] as? String
        self.time = dic["time"] as? Int
        self.mail = dic["email"] as? String
    }
}
