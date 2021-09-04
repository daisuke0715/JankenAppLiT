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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    
    let handImages: [String] = ["goo", "choki", "paa"]
    
    // プレイヤーのジャンケンの手を種類を格納する変数
    var playerHand: Int!
    
    // CPUのジャンケンの手の種類を格納する変数
    var cpuHand: Int!
    
    // 勝利した問題数のカウント
    var winCount: Int = 0
    
    // 経過した時間
    var timer: Timer!
    var pastTime: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        cpuImageView.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func setTimer() {
        pastTime = 0
        // タイマークラスのインスタンス化
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.perSecTimer), userInfo: nil, repeats: true)
    }
    
    @objc func perSecTimer() {
        pastTime += 1
        timerLabel.text = "現在" + String(self.pastTime) + "秒"
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
            winCount += 1
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
            winCount += 1
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
            winCount += 1
        case 1:
            resultLabel.text = "敗北..."
        case 2:
            resultLabel.text = "あいこで..."
        default:
            return
        }
    }
    
    // コンピュータの出す手の種類を返す
    func jankenCPU() -> Int {
        return Int.random(in: 0..<3)
    }
    
    // 対戦回数をカウントして、10回対戦を実施すれば、画面遷移
    func judgeTransition() {
        winCountLabel.text = String("現在\(winCount)勝!")
        
        if winCount == 10 {
            timer.invalidate()
            performSegue(withIdentifier: "toResult", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            let resultVC: ResultViewController = segue.destination as! ResultViewController
            resultVC.pastTime = self.pastTime
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
