//
//  QuestionViewController.swift
//  TBI App
//
//  Created by George McDonnell on 25/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    var pageTitles = [String]?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = viewController as!
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
    }

}
