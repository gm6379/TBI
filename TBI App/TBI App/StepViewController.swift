//
//  StepViewController.swift
//  TBI App
//
//  Created by George McDonnell on 16/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class StepViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
}

class StepViewControllerFactory: NSObject {
    
    var storyboard: UIStoryboard?
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
        super.init()
    }
}