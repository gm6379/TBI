//
//  ImageQuestionViewController.swift
//  TBI App
//
//  Created by George McDonnell on 25/01/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class ImageQuestionViewController: QuestionViewController {
    
    @IBOutlet var images: [UIImageView]!
    @IBOutlet var checks: [UIImageView]!
    @IBOutlet var captions: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        images.sortInPlace({ $0.tag < $1.tag })
        checks.sortInPlace({ $0.tag < $1.tag })
        captions.sortInPlace({ $0.tag < $1.tag })

        let options = question!.options
        for var i = 0; i < images!.count; i++ {
            let option = options!["option" + String(i + 1)]
            let imageView = images[i]
            let captionLabel = captions[i]
            
            let caption = option!["caption"] as! String
            captionLabel.text = caption
            
            let imageName = option!["image"] as! String
            imageView.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        for check in checks {
            if (check.tag == sender.view!.tag) {
                check.hidden = !check.hidden
            }
        }
    }
    
    override func answerQuestion() {
        super.answerQuestion()
        
        var answers = [Dictionary<String, AnyObject>]()
        let questionType = question?.readableType()
        
        let answer = CoreDataManager.fetchAnswerFromQuestionType(question!.readableType())
        
        for check in checks {
            if (!check.hidden) {
                for var i = 0; i < captions.count; i++ {
                    let label = captions[i]
                    let image = images[i];
                    if (check.tag == label.tag && check.tag == image.tag) {
                        let options: [String : AnyObject] = question!.options!
                        let image = options["option" + String(i + 1)]!.objectForKey("image")!
                        let answer: Dictionary<String, AnyObject> = ["caption" : label.text!, "image" : image]
                        answers.append(answer)
                    }
                }
            }
        }
        
        let answerData: Dictionary<String, AnyObject> = ["answers" : answers, "questionType" : question!.readableType()]
        
        if (answer == nil) {
            CoreDataManager.createAnswer(questionType!, answerDictionary: answerData)
        } else {
            CoreDataManager.updateAnswer(answer!, withAnswerDictionary: answerData)
        }
    }
    
}
