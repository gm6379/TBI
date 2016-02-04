//
//  QuestionViewController.swift
//  TBI App
//
//  Created by George McDonnell on 25/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

protocol QuestionViewControllerDelegate {
    func didAnswerQuestion()
}

class QuestionViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!

    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = question!.title
    }
}

class QuestionViewControllerHelper: NSObject {
    
    var storyboard: UIStoryboard?
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
        super.init()
    }
    
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
    
    
}