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
        let questionType = question!.readableType()
        let answerData: Dictionary<String, AnyObject> = ["questionType" : question!.readableType(), "answers" : ["answerText" : answerText!]]
        
        let answer = CoreDataManager.fetchAnswerFromQuestionType(questionType)
        if (answer == nil) {
            CoreDataManager.createAnswer(questionType, answerDictionary: answerData)
        } else {
            CoreDataManager.updateAnswer(answer!, withAnswerDictionary: answerData)
        }
        
        self.delegate?.questionViewController(self, didAnswerQuestion: question!)
    }
}
