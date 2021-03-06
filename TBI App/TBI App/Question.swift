//
//  Question.swift
//  TBI App
//
//  Created by George McDonnell on 31/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

enum QuestionType {
    case Gender; case Age; case AOCHygiene; case AOCComms; case AOCMobility; case AOCHome; case AOCHealth; case AOCSndHome; case TopAOC; case HelpAOC; case RehabAreas; case WhoHelpRehabAreas; case FreqHelpRehabAreas; case Completed
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
            return "AreasOfConcernCommunication"
        case .AOCMobility:
            return "AreasOfConcernMobility"
        case .AOCHome:
            return "AreasOfConcernHomeLife"
        case .AOCHealth:
            return "AreasOfConcernHealth"
        case .AOCSndHome:
            return "AreasOfConcernSecondHomeLife"
        case .TopAOC:
            return "TopAOC"
        case .HelpAOC:
            return "AOCWhereReceivingHelp"
        case .RehabAreas:
            return "AreasWhereReceivingRehabilitation"
        case .WhoHelpRehabAreas:
            return "WhoHelpPatientWithRehabilitationArea"
        case .FreqHelpRehabAreas:
            return "FrequencyOfRehabilitationHelpInSpecifiedArea"
        case .Completed:
            return "CompletedSurvey"
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
        let options = ["option1" : NSLocalizedString("18-24", comment: ""), "option2" : NSLocalizedString("25-34", comment: ""), "option3" : NSLocalizedString("35-44", comment: ""), "option4" : NSLocalizedString("45-54", comment: ""), "option5" : NSLocalizedString("55-64", comment: ""), "option6" : NSLocalizedString("65+", comment: "")]
        
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
    
    func generatedConcernsQuestion(concerns: [Answer], title: String, questionType: QuestionType) -> Question? {
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
        
        let concernsQuestion = Question(type: questionType, title: title, options: options, multipleChoice: true)
        
        return concernsQuestion
    }
    
    func helpAOCQuestion() -> Question? {
        var helpAOCQuestion: Question?
        let helpAOCTitle = NSLocalizedString("Tap concerns where you are receiving help", comment: "")
        if let answer = CoreDataManager.fetchTopAreasOfConcernAnswer() {
            helpAOCQuestion = generatedConcernsQuestion([answer], title: helpAOCTitle, questionType: .HelpAOC)
        } else { // the user had <=3 initial concerns
            // iterate through the area of concern answers and collect into an array
            if let answers = CoreDataManager.fetchAreaOfConcernAnswers() {
                helpAOCQuestion = generatedConcernsQuestion(answers, title: helpAOCTitle, questionType: .HelpAOC)
            }
        }
        
        return helpAOCQuestion
    }
    
    func rehabilitationAreasQuestion() -> Question {
        let title = NSLocalizedString("Tap on areas where you are receiving rehabilitation", comment: "")
        let options = ["option1" : NSLocalizedString("Vision", comment: ""), "option2" : NSLocalizedString("Hearing", comment: ""), "option3" : NSLocalizedString("Speaking", comment: ""), "option4" : NSLocalizedString("Learning or Memory", comment: ""), "option5" : NSLocalizedString("Mental Health", comment: ""), "option6" : NSLocalizedString("Headache", comment: ""), "option7" : NSLocalizedString("Fatigue", comment: ""), "option8" : NSLocalizedString("Pain", comment: ""), "option9" : NSLocalizedString("Behaviour Problems", comment: ""), "option10" : NSLocalizedString("Cooking Food", comment: ""), "option11" : NSLocalizedString("Self Care", comment: ""), "option12" : NSLocalizedString("Sexual Function", comment:""), "option13" : NSLocalizedString("Running", comment: ""), "option14" : NSLocalizedString("Walking", comment: ""), "option15" : NSLocalizedString("Standing", comment: ""), "option16" : NSLocalizedString("Balance", comment: "")]

        let rehabilitationAreasQuestion = Question(type: .RehabAreas, title: title, options: options, multipleChoice: true)
        return rehabilitationAreasQuestion
    }
    
    func whoHelpRehabAreaQuestion(area: String) -> Question {
        let title = NSLocalizedString("You selected " + area + "\n Who is helping you?", comment: "")
        let options = ["option1" : NSLocalizedString("Health Professionals", comment: ""), "option2" : NSLocalizedString("Alternative Therapy", comment: ""), "option3" : NSLocalizedString("Family Members", comment: ""), "option4" : NSLocalizedString("Support Groups", comment: ""), "option5" : NSLocalizedString("Other", comment: "")]
        
        let whoHelpQuestion = Question(type: QuestionType.WhoHelpRehabAreas, title: title, options: options, multipleChoice: false)
        return whoHelpQuestion
    }
    
    func freqHelpRehabQuestion(area: String) -> Question {
        let title = NSLocalizedString("You selected " + area + "\n How many times per week?", comment: "")
        let options = ["option1" : NSLocalizedString("1-2", comment: ""), "option2" : NSLocalizedString("3-4", comment: ""), "option3" : NSLocalizedString("5-6", comment: ""), "option4" : NSLocalizedString("7", comment: "")]
        
        let freqHelpQuestion = Question(type: QuestionType.FreqHelpRehabAreas, title: title, options: options, multipleChoice: false)
        return freqHelpQuestion
    }
    
    func completedSurveyQuestion() -> Question {
        let title = NSLocalizedString("Thank you for completing this survey!", comment: "")
        let options = ["option1" : NSLocalizedString("Tap here to finish", comment: "")]
        
        let completedSurveyQuestion = Question(type: QuestionType.Completed, title: title, options: options, multipleChoice: false)
        return completedSurveyQuestion
    }
}
