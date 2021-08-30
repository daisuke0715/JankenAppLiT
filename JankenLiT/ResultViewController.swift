//
//  ResultViewController.swift
//  JankenLiT
//
//  Created by 河村大介 on 2021/08/30.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var pastTimeLabel: UILabel!
    
    var pastTime: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pastTimeLabel.text = String(pastTime)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
