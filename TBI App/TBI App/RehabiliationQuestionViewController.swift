//
//  RehabiliationQuestionViewController.swift
//  TBI App
//
//  Created by George McDonnell on 02/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class RehabiliationQuestionViewController: QuestionViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionsView: UIView!
    
    var displayOptions =  [String]()
    var selectedOptions = [String]()
    var temporarySelectedOptions = [String]()
    
    var options = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        options = question!.options! as! [String : String]
    }
    
    @IBAction func headTapped() {
        displayOptions = [options["option1"]!,
                          options["option2"]!,
                          options["option3"]!,
                          options["option4"]!,
                          options["option5"]!,
                          options["option6"]!]
        displayOptionsView()
    }
    
    @IBAction func upperBodyTapped() {
        displayOptions = [options["option7"]!,
                          options["option8"]!,
                          options["option9"]!]
        displayOptionsView()
    }
    
    @IBAction func handTapped() {
        displayOptions = [options["option10"]!,
                          options["option11"]!]
        displayOptionsView()
    }
    
    @IBAction func groinTapped() {
        displayOptions = [options["option12"]!]
        displayOptionsView()
    }
    
    @IBAction func legsTapped() {
        displayOptions = [options["option13"]!,
                          options["option14"]!,
                          options["option15"]!,
                          options["option16"]!]
        displayOptionsView()
    }
    
    func displayOptionsView() {
        temporarySelectedOptions.appendContentsOf(selectedOptions)
        tableView.reloadData()
        UIView.animateWithDuration(0.3) { () -> Void in
            self.optionsView.alpha = 1;
        }
    }
    
    @IBAction func cancel() {
        hideOptions()
    }
    
    @IBAction func confirm() {
        selectedOptions.removeAll()
        selectedOptions.appendContentsOf(temporarySelectedOptions)
        temporarySelectedOptions.removeAll()
        hideOptions()
    }

    func hideOptions() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.optionsView.alpha = 0;
        }
    }
    
    override func answerQuestion() -> Bool {
        super.answerQuestion()
        
        let questionType = question?.readableType()
        let answerData: Dictionary<String, AnyObject> = ["questionType" : question!.readableType(), "answers" : selectedOptions]
        
        let answer = CoreDataManager.fetchAnswerFromQuestionType(question!.readableType())
        if (answer == nil) {
            CoreDataManager.createAnswer(questionType!, answerDictionary: answerData)
        } else {
            CoreDataManager.updateAnswer(answer!, withAnswerDictionary: answerData)
        }
        
        return true
    }
    
}

extension RehabiliationQuestionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RehabilitationOptionTableViewCell", forIndexPath: indexPath) as! RehabilitationOptionTableViewCell
        let text = displayOptions[indexPath.row]
        let index = selectedOptions.indexOf(text)
        if (index != nil) {
            cell.checkImageView.hidden = false
        } else {
            cell.checkImageView.hidden = true
        }
        
        cell.label?.text = text
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RehabilitationOptionTableViewCell
        cell.checkImageView.hidden = !cell.checkImageView.hidden
        let text = cell.label.text!
        
        if let index = temporarySelectedOptions.indexOf(text) {
            temporarySelectedOptions.removeAtIndex(index)
        } else {
            temporarySelectedOptions.append(text)
        }
    }
    
}
