//
//  QuestionViewController.swift
//  TBI App
//
//  Created by George McDonnell on 25/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

protocol QuestionViewControllerDelegate {
    func questionViewController(viewController: QuestionViewController, didAnswerQuestion: Question)
}

class QuestionViewController: StepViewController {
    
    var delegate: QuestionViewControllerDelegate?

    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = question!.title
    }
    
    func answerQuestion() -> Bool {
        return false
    }
    
}

class QuestionViewControllerFactory: StepViewControllerFactory {
    
    func ageQuestionViewController() -> TextStyleAnswerQuestionViewController {
        let ageQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("AgeQuestionViewController") as! TextStyleAnswerQuestionViewController
        return ageQuestionViewController
    }
    
    func genderQuestionViewController() -> TextStyleAnswerQuestionViewController {
        let genderQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("GenderQuestionViewController") as! TextStyleAnswerQuestionViewController
        return genderQuestionViewController
    }
    
    func imageQuestionViewController() -> ImageQuestionViewController {
        let imageQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("ImageQuestionViewController") as! ImageQuestionViewController
        return imageQuestionViewController
    }
    
    func threeImageQuestionViewController() -> ImageQuestionViewController {
        let imageQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("ThreeImageQuestionViewController") as! ImageQuestionViewController
        return imageQuestionViewController
    }
    
    func topConcernsQuestionViewController() -> QuestionViewController {
        let topConcernsQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("TopConcernsQuestionViewController") as! TopConcernsQuestionViewController
        return topConcernsQuestionViewController
    }
    
    func rehabilitationQuestionViewController() -> QuestionViewController {
        let rehabilitationQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("RehabiliationQuestionViewController") as! RehabiliationQuestionViewController
        return rehabilitationQuestionViewController
    }
    
    func whoHelpQuestionViewController() -> TextStyleAnswerQuestionViewController {
        let ageQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("WhoHelpRehabQuestionViewController") as! TextStyleAnswerQuestionViewController
        return ageQuestionViewController
    }
    
    func freqHelpQuestionViewController() -> TextStyleAnswerQuestionViewController {
        let ageQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("FreqHelpRehabQuestionViewController") as! TextStyleAnswerQuestionViewController
        return ageQuestionViewController
    }
    
    func finishedSurveyViewController() -> TextStyleAnswerQuestionViewController {
        let finishedSurveyViewController = storyboard?.instantiateViewControllerWithIdentifier("FinishedQuestionViewController") as! TextStyleAnswerQuestionViewController
        return finishedSurveyViewController
    }
}