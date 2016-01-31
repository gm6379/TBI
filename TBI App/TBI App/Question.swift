//
//  Question.swift
//  TBI App
//
//  Created by George McDonnell on 31/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

enum QuestionType {
    case Gender; case Age; case AreaOfConcern
}

class Question: NSObject {
    
    var type: QuestionType?
    var title: String?
    var options: Dictionary<String, AnyObject>?
    var multipleChoice: Bool?
    
    init(type:QuestionType, title:String, options: Dictionary<String, AnyObject>) {
        self.type = type
        self.title = title
        self.options = options
        super.init()
    }
}
