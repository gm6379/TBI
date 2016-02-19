//
//  ViewController.swift
//  TBI App
//
//  Created by George McDonnell on 19/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, QuestionViewControllerDelegate, OnBoardingStepViewControllerDelegate {
    
    var pageViewController: UIPageViewController?
    var currentIndex = 0
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var backArrow: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var sVcs = [StepViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.borderColor = nextButton.tintColor!.CGColor
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 5
        nextButton.layer.masksToBounds = true
        
        // Disable swipe to scroll
        for view in pageViewController!.view.subviews {
            if (view.isKindOfClass(UIScrollView)) {
                (view as! UIScrollView).scrollEnabled = false
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedPageViewControllerSegue") {
            let helper = QuestionHelper()
            
            let questions = [helper.genderQuestion(),
                             helper.ageQuestion(),
                             helper.hygieneAOCQuestion(),
                             helper.communicationAOCQuestion(),
                             helper.mobilityAOCQuestion(),
                             helper.homeLifeAOCQuestion(),
                             helper.healthAOCQuestion(),
                             helper.secondHomeLifeAOCQuestion()]
            
            let osVcFactory = OnBoardingStepViewControllerFactory(storyboard: storyboard!)
            let oSvcs:[StepViewController] = [osVcFactory.loginViewController()]
            
            let qVcFactory = QuestionViewControllerFactory(storyboard: storyboard!)
            let qVcs: [StepViewController] = [qVcFactory.genderQuestionViewController(),
                    qVcFactory.ageQuestionViewController(),
                    qVcFactory.imageQuestionViewController(),
                    qVcFactory.imageQuestionViewController(),
                    qVcFactory.imageQuestionViewController(),
                    qVcFactory.imageQuestionViewController(),
                    qVcFactory.imageQuestionViewController(),
                    qVcFactory.imageQuestionViewController()]
            
            for var i = 0; i < questions.count; i++ {
                let question = questions[i]
                let qVc = qVcs[i] as! QuestionViewController
                
                qVc.question = question
                qVc.delegate = self
            }
            
            for sVc in oSvcs {
                let vc = sVc as! OnBoardingStepViewController
                vc.delegate = self
            }
            
            sVcs = [StepViewController]()
            sVcs += oSvcs
            sVcs += qVcs
            
            let pageViewController = segue.destinationViewController as! UIPageViewController
            self.pageViewController = pageViewController
            
            self.pageViewController!.dataSource = self;

            self.pageViewController?.setViewControllers([sVcs.first!], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
    }
    
    @IBAction func nextQuestion() {
        if (sVcs[currentIndex].isKindOfClass(QuestionViewController)) {
            let currentSVC = sVcs[currentIndex] as! QuestionViewController
            let currentQuestion = currentSVC.question
            if (currentQuestion?.multipleChoice == true) {
                currentSVC.answerQuestion()
            }
        }
        
        
        if (currentIndex != sVcs.count - 1) {
            let nextIndex = abs((currentIndex + 1) % sVcs.count)
            let nextStepVC = sVcs[nextIndex]
            pageViewController?.setViewControllers([nextStepVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            currentIndex = nextIndex
            if (nextStepVC.isKindOfClass(QuestionViewController)) {
                if ((nextStepVC as! QuestionViewController).question?.multipleChoice == true) {
                    nextButton.hidden = false
                } else {
                    nextButton.hidden = true
                }
            }
            backArrow.hidden = false
            backButton.enabled = true
        }
    }
    
    @IBAction func previousQuestion() {
        if (currentIndex != 0) {
            let previousIndex = abs((currentIndex - 1) % sVcs.count)
            let prevStepVC = sVcs[previousIndex]

            pageViewController?.setViewControllers([prevStepVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            currentIndex = previousIndex
            if (prevStepVC.isKindOfClass(QuestionViewController)) {
                if ((prevStepVC as! QuestionViewController).question?.multipleChoice == true) {
                    nextButton.hidden = false
                } else {
                    nextButton.hidden = true
                }
            }
            
            if (currentIndex == 0) {
                backArrow.hidden = true
                backButton.enabled = false
            }
        }
    }
    
    @IBAction func exportData(sender: UIButton) {
        CoreDataManager.export()
    }
    
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        currentIndex = sVcs.indexOf(viewController as! QuestionViewController)!
        
        if (currentIndex == 0) {
            return nil;
        }
        
        let previousIndex = abs((currentIndex - 1) % sVcs.count)
        return sVcs[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        currentIndex = sVcs.indexOf(viewController as! QuestionViewController)!
        
        if (currentIndex == sVcs.count - 1) {
            return nil;
        }
        
        let nextIndex = abs((currentIndex + 1) % sVcs.count)
        return sVcs[nextIndex]
    }
    
    // MARK: - QuestionViewControllerDelgate
    
    func questionViewController(viewController: QuestionViewController, didAnswerQuestion: Question) {
        nextQuestion()
    }
    
    // MARK: - OnBoardingViewControllerDelegate
    
    func didCompleteOnBoardingStep() {
        nextQuestion()
    }

    
}

