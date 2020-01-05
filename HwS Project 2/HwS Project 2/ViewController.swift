//
//  ViewController.swift
//  HwS Project 2
//
//  Created by Heather Mason on 1/3/20.
//  Copyright © 2020 Heather Mason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        let buttons = [button1, button2, button3]
        
        for button in buttons {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
        }

        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Score: \(score)  |  Next up: \(countries[correctAnswer].uppercased())"
        questionsAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, that's the flag of \((countries[sender.tag]).uppercased())"
            score -= 1
        }

        var message = "Your score is \(score)"
        var actionTitle = "Continue"
        var handler = askQuestion
        if questionsAsked == 10 {
            message = "Your final score is \(score)"
            actionTitle = "Restart"
            handler = restart
            
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(ac, animated: true)
    }
    
    func restart(action: UIAlertAction! = nil) {
        correctAnswer = 0
        questionsAsked = 0
        score = 0
        askQuestion()
    }
    
}

