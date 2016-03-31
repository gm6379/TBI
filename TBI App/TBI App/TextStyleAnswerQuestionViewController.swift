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
        if (answerText == NSLocalizedString("Other", comment: "")) {
            promptOtherDialog()
        } else {
            answer(answerText!)
        }
    }
    
    func promptOtherDialog() {
        let alert = UIAlertController(title: "Confirm answer", message: "Please specify your answer:", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            let answerTextField = alert.textFields![0] as UITextField
            if (answerTextField.text != nil) {
                self.answer(answerTextField.text!)
            } else {
                self.answer(NSLocalizedString("Other", comment: ""))
            }
        }))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func answer(answerText: String) {
        let questionType = question!.readableType()
        let answerData: Dictionary<String, AnyObject> = ["questionType" : question!.readableType(), "answers" : [answerText]]
        
        let answer = CoreDataManager.fetchAnswerFromQuestionType(questionType)
        if (answer == nil) {
            CoreDataManager.createAnswer(questionType, answerDictionary: answerData)
        } else {
            CoreDataManager.updateAnswer(answer!, withAnswerDictionary: answerData)
        }
        
        self.delegate?.questionViewController(self, didAnswerQuestion: question!)
    }
}
