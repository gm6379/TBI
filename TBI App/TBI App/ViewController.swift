//
//  ViewController.swift
//  TBI App
//
//  Created by George McDonnell on 19/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    @IBOutlet weak var containerView: UIView!
    
    var qVcs = [QuestionViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = qVcs.indexOf(viewController as! QuestionViewController)!
        
        if (currentIndex == 0) {
            return nil;
        }
        
        let previousIndex = abs((currentIndex - 1) % qVcs.count)
        return qVcs[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = qVcs.indexOf(viewController as! QuestionViewController)!
        
        if (currentIndex == qVcs.count - 1) {
            return nil;
        }
        
        let nextIndex = abs((currentIndex + 1) % qVcs.count)
        return qVcs[nextIndex]
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
            
            let vcHelper = QuestionViewControllerHelper(storyboard: storyboard!)
            qVcs = [vcHelper.genderQuestionViewController(),
                    vcHelper.ageQuestionViewController(),
                    vcHelper.imageQuestionViewController(),
                    vcHelper.imageQuestionViewController(),
                    vcHelper.imageQuestionViewController(),
                    vcHelper.imageQuestionViewController(),
                    vcHelper.imageQuestionViewController(),
                    vcHelper.imageQuestionViewController()]
            
            for var i = 0; i < questions.count; i++ {
                let question = questions[i]
                let qVc = qVcs[i]
                
                qVc.question = question
            }
            
            let pageViewController = segue.destinationViewController as! UIPageViewController
            self.pageViewController = pageViewController
            
            self.pageViewController!.dataSource = self;

            self.pageViewController?.setViewControllers([qVcs.first!], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
    }
}

