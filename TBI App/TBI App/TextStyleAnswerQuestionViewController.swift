//
//  TwoAnswerQuestionViewController.swift
//  TBI App
//
//  Created by George McDonnell on 31/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class TextStyleAnswerQuestionViewController: QuestionViewController {
    
    @IBOutlet var answerButtons : [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let options = question!.options
        for var i = 0; i < answerButtons!.count; i++ {
            let button = answerButtons[i]
            let option = options!["option" + String(i + 1)] as! String
            button.setTitle(option, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func answerQuestion(button: UIButton) {
        let answerText = button.titleLabel?.text
        let currentSession = SessionManager.sharedManager.currentSession
        
        CoreDataManager.createAnswerWithSession(currentSession!, answerDictionary: ["questionType" : question!.readableType(), "answerText" : answerText!])
        
        self.delegate?.questionViewController(self, didAnswerQuestion: question!)
    }
}
