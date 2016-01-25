//
//  ViewController.swift
//  TBI App
//
//  Created by George McDonnell on 19/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startSurvey(sender: UIButton) {
        let task = ORKOrderedTask(identifier: "task", steps: [genderStep(), ageStep()])
        
        let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }

    func genderStep() -> ORKQuestionStep {
        let title = "What is your gender?"
        
        let textChoiceOneText = NSLocalizedString("Male", comment: "")
        let textChoiceTwoText = NSLocalizedString("Female", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "choice_1"),
            ORKTextChoice(text: textChoiceTwoText, value: "choice_2"),
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: String("gender"), title: title, answer: answerFormat)
        
        return questionStep
    }
    
    func ageStep() -> ORKQuestionStep {
        let title = "What is your age?"
        
        let ageChoiceOneText = NSLocalizedString("18-24", comment: "")
        let ageChoiceTwoText = NSLocalizedString("25-34", comment: "")
        let ageChoiceThreeText = NSLocalizedString("35-44", comment: "")
        let ageChoiceFourText = NSLocalizedString("45-54", comment: "")
        let ageChoiceFiveText = NSLocalizedString("55-64", comment: "")
        let ageChoiceSixText = NSLocalizedString("65+", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: ageChoiceOneText, value: "choice_1"),
            ORKTextChoice(text: ageChoiceTwoText, value: "choice_2"),
            ORKTextChoice(text: ageChoiceThreeText, value: "choice_3"),
            ORKTextChoice(text: ageChoiceFourText, value: "choice_4"),
            ORKTextChoice(text: ageChoiceFiveText, value: "choice_5"),
            ORKTextChoice(text: ageChoiceSixText, value: "choice_6"),
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: String("age"), title: title, answer: answerFormat)
        
        return questionStep
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
    }
}

