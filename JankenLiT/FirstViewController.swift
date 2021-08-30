//
//  FirstViewController.swift
//  JankenLiT
//
//  Created by 河村大介 on 2021/08/30.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var cpuImageView: UIImageView!
    
    let handImages: [String] = ["goo", "choki", "paa"]
    
    // プレイヤーのジャンケンの手を種類を格納する変数
    var playerHand: Int!
    
    // CPUのジャンケンの手の種類を格納する変数
    var cpuHand: Int!
    
    // 勝利した問題数のカウント
    var count: Int = 0
    
    // 勝負回数のカウント
    var judgeCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ジャンケンのボタンがクリックされた時の挙動
    /*
     0 => グー
     1 => チョキ
     2 => パー
     */
    @IBAction func goo() {
        cpuHand = jankenCPU()
        cpuImageView.image = UIImage(named: handImages[cpuHand])
        playerHand = 0
        switch cpuHand {
        case 0:
            resultLabel.text = "あいこで..."
        case 1:
            resultLabel.text = "勝利！"
            count += 1
        case 2:
            resultLabel.text = "敗北..."
        default:
            return
        }
        judgeTransition()
    }
    @IBAction func choki() {
        cpuHand = jankenCPU()
        cpuImageView.image = UIImage(named: handImages[cpuHand])
        playerHand = 1
        switch cpuHand {
        case 0:
            resultLabel.text = "敗北！"
        case 1:
            resultLabel.text = "あいこで..."
        case 2:
            resultLabel.text = "勝利！"
            count += 1
        default:
            return
        }
        judgeTransition()
    }
    @IBAction func paa() {
        cpuHand = jankenCPU()
        cpuImageView.image = UIImage(named: handImages[cpuHand])
        playerHand = 2
        switch cpuHand {
        case 0:
            resultLabel.text = "勝利！"
            count += 1
        case 1:
            resultLabel.text = "敗北..."
        case 2:
            resultLabel.text = "あいこで..."
        default:
            return
        }
        judgeTransition()
    }
    
    // コンピュータの出す手の種類を返す
    func jankenCPU() -> Int {
        return Int.random(in: 0..<3)
    }
    
    // 対戦回数をカウントして、10回対戦を実施すれば、画面遷移
    func judgeTransition() {
        judgeCount += 1
        if judgeCount == 10 {
            performSegue(withIdentifier: "toResult", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
