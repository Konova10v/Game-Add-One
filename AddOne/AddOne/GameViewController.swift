//
//  ViewController.swift
//  AddOne
//
//  Created by Кирилл Коновалов on 10.09.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    var score = 0
    var timer: Timer?
    var second = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateScoreLabel()
        updateNumberLabel()
        updateTimerLabel()
        
        inputField?.addTarget(self, action: #selector(inputDieldDidChange), for: .editingChanged)
        
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = String(score)
    }
    
    func updateNumberLabel() {
        numberLabel?.text = String.randomNumber(length: 4)
    }
    
    @IBAction func inputDieldDidChange() {
        guard let numberText = numberLabel?.text, let inputText = inputField?.text else { return }
        guard inputText.count == 4 else { return }
        
        var isCorrect = true
        
        for n in 0..<4 {
            var input = inputText.integer(n: n)
            let number = numberText.integer(n: n)
            
            if input == 0 {
                input = 10
            }
            
            if input != number + 1 {
                isCorrect = false
                break
            }
            
            if isCorrect {
                score += 1
            } else {
                score -= 1
            }
            
            updateNumberLabel()
            updateScoreLabel()
            inputField?.text = ""
            
            if timer == nil {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    if self.second == 0 {
                        self.finishGame()
                    } else if self.second <= 60 {
                        self.second -= 1
                        self.updateTimerLabel()
                    }
                }
            }
        }
    }
    
    func updateTimerLabel() {
        let min = (second / 60) % 60
        let sec = second % 60
        
        timerLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    func finishGame() {
        timer?.invalidate()
        timer = nil
        
        let alert = UIAlertController(title: "Time's UP", message: "Your time is up! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        score = 0
        second = 60
        
        updateTimerLabel()
        updateScoreLabel()
        updateNumberLabel()
    }
}

