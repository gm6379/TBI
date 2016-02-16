//
//  OnBoardingStepViewController.swift
//  TBI App
//
//  Created by George McDonnell on 16/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

protocol OnBoardingStepViewControllerDelegate {
    func didCompleteOnBoardingStep()
}

class OnBoardingStepViewController: StepViewController {

    var delegate: OnBoardingStepViewControllerDelegate?
}

class OnBoardingStepViewControllerFactory: StepViewControllerFactory {
    
    func loginViewController() -> LoginViewController {
        let loginViewController = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        return loginViewController
    }
}