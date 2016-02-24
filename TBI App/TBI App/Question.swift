//
//  Question.swift
//  TBI App
//
//  Created by George McDonnell on 31/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

enum QuestionType {
    case Gender; case Age; case AOCHygiene; case AOCComms; case AOCMobility; case AOCHome; case AOCHealth; case AOCSndHome, TopAOC
}

class Question: Step {
    
    var type: QuestionType?
    var options: Dictionary<String, AnyObject>?
    var multipleChoice: Bool?
    
    init(type: QuestionType, title: String, options: Dictionary<String, AnyObject>, multipleChoice: Bool) {
        self.type = type
        self.options = options
        self.multipleChoice = multipleChoice
        super.init(title: title)
    }
    
    func readableType() -> String {
        switch type! {
        case .Gender:
            return "Gender"
        case .Age:
            return "Age"
        case .AOCHygiene:
            return "AreasOfConcernHygiene"
        case .AOCComms:
            return "AreasOfConcernCommuniation"
        case .AOCMobility:
            return "AreasOfConcernMobility"
        case .AOCHome:
            return "AreasOfConcernHomeLife"
        case .AOCHealth:
            return "AreasOfConcernHealth"
        case .AOCSndHome:
            return "AreasOfConcernSecondHomeLife"
        case .TopAOC:
            return "TopAreasOfConcern"
        }
    }
}

class QuestionHelper: NSObject {
    
    func genderQuestion() -> Question {
        let title = NSLocalizedString("What is your gender?", comment: "")
        let options = ["option1" : NSLocalizedString("Male", comment: ""), "option2" : NSLocalizedString("Female", comment: "")]
        
        let genderQuestion = Question(type: QuestionType.Gender, title: title, options: options, multipleChoice: false)
        return genderQuestion
    }
    
    func ageQuestion() -> Question {
        let title = NSLocalizedString("What is your age?", comment: "")
        let options = ["option1" : "18-24", "option2" : "25-34", "option3" : "35-44", "option4" : "45-54", "option5" : "55-64", "option6" : "65+", ]
        
        let ageQuestion = Question(type: QuestionType.Age, title: title, options: options, multipleChoice: false)
        return ageQuestion
    }
    
    func hygieneAOCQuestion() -> Question {
        let title = NSLocalizedString("Tap on your areas of concern", comment: "")
        let options = ["option1" : ["image" : "toilet", "caption" : NSLocalizedString("Using a toilet", comment: "")],
            "option2" : ["image" : "bathtub", "caption" : NSLocalizedString("Bathing", comment: "")],
            "option3" : ["image" : "shower", "caption" : NSLocalizedString("Showering", comment: "")],
            "option4" : ["image" : "toothbrush", "caption" : NSLocalizedString("Brushing Teeth", comment: "")]
        ]
        
        let hygieneAOCQuestion = Question(type: QuestionType.AOCHygiene, title: title, options: options, multipleChoice: true)
        return hygieneAOCQuestion
    }
    
    func communicationAOCQuestion() -> Question {
        let title = NSLocalizedString("Tap on your areas of concern", comment: "")
        let options = ["option1" : ["image" : "discussion", "caption" : NSLocalizedString("Speech", comment: "")],
            "option2" : ["image" : "telephone", "caption" : NSLocalizedString("Using a telephone", comment: "")],
            "option3" : ["image" : "email", "caption" : NSLocalizedString("Email",comment: "")],
            "option4" : ["image" : "internet", "caption" : NSLocalizedString("Internet Browsing", comment: "")]
        ]
        
        let communicationAOCQuestion = Question(type: QuestionType.AOCComms, title: title, options: options, multipleChoice: true)
        return communicationAOCQuestion
    }
    
    func mobilityAOCQuestion() -> Question {
        let title = NSLocalizedString("Tap on your areas of concern", comment: "")
        let options = ["option1" : ["image" : "walking", "caption" : NSLocalizedString("Mobility", comment: "")],
            "option2" : ["image" : "driving", "caption" : NSLocalizedString("Driving", comment: "")],
            "option3" : ["image" : "bus", "caption" : NSLocalizedString("Bus Travel", comment: "")],
            "option4" : ["image" : "train", "caption" : NSLocalizedString("Train Travel", comment: "")]
        ]
        
        let mobilityAOCQuestion = Question(type: QuestionType.AOCMobility, title: title, options: options, multipleChoice: true)
        return mobilityAOCQuestion
    }
    
    func homeLifeAOCQuestion() -> Question {
        let title = NSLocalizedString("Tap on your areas of concern", comment: "")
        let options = ["option1" : ["image" : "eating", "caption" : NSLocalizedString("Eating",   comment: "")],
            "option2" : ["image" : "sleeping", "caption" : NSLocalizedString("Sleeping", comment: "")],
            "option3" : ["image" : "dressing", "caption" : NSLocalizedString("Dressing", comment: "")],
            "option4" : ["image" : "shopping", "caption" : NSLocalizedString("Shopping", comment: "")]
        ]
        
        let mobilityAOCQuestion = Question(type: QuestionType.AOCHome, title: title, options: options, multipleChoice: true)
        return mobilityAOCQuestion
    }
    
    func healthAOCQuestion() -> Question {
        let title = NSLocalizedString("Tap on your areas of concern", comment: "")
        let options = ["option1" : ["image" : "love", "caption" : NSLocalizedString("Love", comment: "")],
            "option2" : ["image" : "sex", "caption" : NSLocalizedString("Sex", comment: "")],
            "option3" : ["image" : "medical", "caption" : NSLocalizedString("Medication", comment: "")],
            "option4" : ["image" : "death", "caption" : NSLocalizedString("Death", comment: "")]
        ]
        
        let healthAOCQuestion = Question(type: QuestionType.AOCHealth, title: title, options: options, multipleChoice: true)
        return healthAOCQuestion
    }
    
    func secondHomeLifeAOCQuestion() -> Question {
        let title = NSLocalizedString("Tap on your areas of concern", comment: "")
        let options = ["option1" : ["image" : "family", "caption" : NSLocalizedString("Family", comment: "")],
            "option2" : ["image" : "home", "caption" : NSLocalizedString("Home", comment: "")],
            "option3" : ["image" : "money", "caption" : NSLocalizedString("Money", comment: "")],
            "option4" : ["image" : "pets", "caption" : NSLocalizedString("Pets", comment: "")]
        ]
        
        let homeLifeAOCQuestion = Question(type: QuestionType.AOCSndHome, title: title, options: options, multipleChoice: true)
        return homeLifeAOCQuestion
    }
    
    func topConcernsQuestion(concerns: [Answer]) -> Question? {
        let title = NSLocalizedString("Tap on your top 3 areas of concern", comment: "")
        
        var options = Dictionary<String, AnyObject>()
        for concern in concerns {
            let concernData = NSKeyedUnarchiver.unarchiveObjectWithData(concern.data!) as! NSDictionary
            
            let answers = concernData.objectForKey("answers") as! NSArray
            for answer in answers {
                let caption = answer["caption"] as! String
                let image = answer["image"] as! String
                let option = ["image" : image, "caption" : caption]
                options["option" + String(options.count + 1)] = option
            }
        }
        
        let topConcernsQuestion = Question(type: QuestionType.TopAOC, title: title, options: options, multipleChoice: true)
        
        return topConcernsQuestion
    }
}
