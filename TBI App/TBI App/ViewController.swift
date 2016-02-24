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
    var currentSection = 0
    let numberOfSections = 2
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var backArrow: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var sVCs = [[StepViewController]]()
    var currentSVCs = [StepViewController]()
    
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
            
            loadFirstSectionQuestions()
            
            let pageViewController = segue.destinationViewController as! UIPageViewController
            self.pageViewController = pageViewController
            
            self.pageViewController!.dataSource = self;

            self.pageViewController?.setViewControllers([currentSVCs.first!], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
    }
    
    @IBAction func nextQuestion() {
        if (currentSVCs[currentIndex].isKindOfClass(QuestionViewController)) {
            let currentSVC = currentSVCs[currentIndex] as! QuestionViewController
            let currentQuestion = currentSVC.question
            if (currentQuestion?.multipleChoice == true) {
                currentSVC.answerQuestion()
            }
        }
        
        if (currentIndex != currentSVCs.count - 1) {
            moveToNextStep()
        } else {
            if let section = nextSection() {
                currentSVCs = section
                currentSection++
                currentIndex = -1
                moveToNextStep()
            }
        }
    }
    
    func moveToNextStep() {
        let nextIndex = abs((currentIndex + 1) % currentSVCs.count)
        let nextStepVC = currentSVCs[nextIndex]
        pageViewController?.setViewControllers([nextStepVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        currentIndex = nextIndex
        if (nextStepVC.isKindOfClass(QuestionViewController)) {
            skipButton.hidden = false
            if ((nextStepVC as! QuestionViewController).question?.multipleChoice == true) {
                nextButton.hidden = false
            } else {
                nextButton.hidden = true
            }
        }
        backArrow.hidden = false
        backButton.enabled = true
    }
    
    @IBAction func previousQuestion() {
        if (currentIndex != 0) {
            moveToPreviousStep()
        } else {
            if (currentSection != 0) {
                currentSection--
                currentSVCs = sVCs[currentSection]
                currentIndex = currentSVCs.count
                moveToPreviousStep()
            }
        }
    }
    
    func moveToPreviousStep() {
        let previousIndex = abs((currentIndex - 1) % currentSVCs.count)
        let prevStepVC = currentSVCs[previousIndex]
        
        pageViewController?.setViewControllers([prevStepVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
        currentIndex = previousIndex
        if (prevStepVC.isKindOfClass(QuestionViewController)) {
            if ((prevStepVC as! QuestionViewController).question?.multipleChoice == true) {
                nextButton.hidden = false
            } else {
                nextButton.hidden = true
            }
        } else {
            skipButton.hidden = true
        }
        
        if (currentIndex == 0) {
            backArrow.hidden = true
            backButton.enabled = false
        }
    }
    
    func loadFirstSectionQuestions() {
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
        
        currentSVCs = [StepViewController]()
        currentSVCs += oSvcs
        currentSVCs += qVcs
        
        sVCs.append(currentSVCs)
    }
    
    func secondSectionQuestions() -> [StepViewController]? {
        let helper = QuestionHelper()
        
        var questions = [Question]()
        
        // check if user selected >3 areas of concern
        if let areaOfConcernAnswers = CoreDataManager.fetchAreaOfConcernAnswers() as [Answer]? {
            var numConcerns = 0
            for answer in areaOfConcernAnswers {
                let answerData = NSKeyedUnarchiver.unarchiveObjectWithData(answer.data!)
                let answers = answerData!["answers"] as! [[String : String]]
                numConcerns += answers.count
            }
            if numConcerns > 3 {
                questions.append(helper.topConcernsQuestion(areaOfConcernAnswers)!)
            }
        }
        
        if (questions.count > 0) {
            let qVcFactory = QuestionViewControllerFactory(storyboard: storyboard!)
            let qVcs: [StepViewController] = [qVcFactory.topConcernsQuestionViewController()]
            
            for var i = 0; i < questions.count; i++ {
                let question = questions[i]
                let qVc = qVcs[i] as! QuestionViewController
                
                qVc.question = question
                qVc.delegate = self
            }
            
            return qVcs
        } else {
            return nil
        }
    }
    
    func nextSection() -> [StepViewController]? {
        // load the next section
        if (currentSection != numberOfSections - 1) {
            if (currentSection == 0) {
                if let questions = secondSectionQuestions() {
                    if (sVCs.count == 1) {
                        sVCs.append(questions)
                    }
                    return questions
                }
            }
        }
        
        return nil
    }
    
    @IBAction func exportData(sender: UIButton) {
        CoreDataManager.export()
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        currentIndex = currentSVCs.indexOf(viewController as! QuestionViewController)!
        
        if (currentIndex == 0) {
            return nil;
        }
        
        let previousIndex = abs((currentIndex - 1) % currentSVCs.count)
        return currentSVCs[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        currentIndex = currentSVCs.indexOf(viewController as! QuestionViewController)!
        
        if (currentIndex == currentSVCs.count - 1) {
            return nil;
        }
        
        let nextIndex = abs((currentIndex + 1) % currentSVCs.count)
        return currentSVCs[nextIndex]
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

