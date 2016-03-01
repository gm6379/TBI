//
//  SelectedConernsViewController.swift
//  TBI App
//
//  Created by George McDonnell on 04/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class TopConcernsQuestionViewController: QuestionViewController {
    
    var options: Dictionary<String, AnyObject>?
    var selectedConcerns = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        options = question?.options
    }
    
    override func answerQuestion() -> Bool {
        super.answerQuestion()
        
        if (selectedConcerns.count == 3) {
            let questionType = question!.readableType()
            let answerData: Dictionary<String, AnyObject> = ["answers" : selectedConcerns, "questionType" : question!.readableType()]
            
            let answer = CoreDataManager.fetchAnswerFromQuestionType(questionType)
            if (answer == nil) {
                CoreDataManager.createAnswer(questionType, answerDictionary: answerData)
            } else {
                CoreDataManager.updateAnswer(answer!, withAnswerDictionary: answerData)
            }
            
            self.delegate?.questionViewController(self, didAnswerQuestion: question!)
            return true
        } else {
            displayConcernsAmountError()
            return false
        }
    }
    
    func displayConcernsAmountError() {
        let alert = UIAlertController(title: "Error", message: NSLocalizedString("Please select 3 concerns", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

extension TopConcernsQuestionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TopConcernCollectionViewCell", forIndexPath: indexPath) as! TopConcernCollectionViewCell
        let option = options!["option" + String(indexPath.item + 1)]! as! [String : String]
        let imageName = option["image"]! as String
        cell.imageName = imageName
        cell.concernImageView.image = UIImage(named: imageName)
        let caption = option["caption"]! as String
        cell.caption = caption
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TopConcernCollectionViewCell
        
        let hidden = cell.checkImageView.hidden
        
        if (hidden) {
            if (selectedConcerns.count != 3) {
                selectedConcerns.addObject(["caption" : cell.caption!, "image" : cell.imageName!])
                cell.checkImageView.hidden = !hidden
            }
        } else {
            selectedConcerns.removeObject(["caption" : cell.caption!, "image" : cell.imageName!])
            cell.checkImageView.hidden = !hidden
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var itemsPerRow = 0
        if (options!.count <= 2) {
            itemsPerRow = 1
        } else if (options!.count < 7) {
            itemsPerRow = 2
        } else if (options!.count < 13) {
            itemsPerRow = 3
        } else {
            itemsPerRow = 4
        }
        
        let remainder = options!.count % itemsPerRow
        var cellWidth : CGFloat = 0
        
        // if the index path is within the remainder, divide by that instead of the constant
        if options!.count - indexPath.item <= remainder {
            cellWidth = (collectionView.frame.width / CGFloat(remainder))
        }
        else {
            cellWidth = (collectionView.frame.width / CGFloat(itemsPerRow))
        }
        
        var rows = options!.count / Int(itemsPerRow)
        if options!.count % Int(itemsPerRow) >= 1 {
            rows += 1
        }
        
        var cellHeight = collectionView.frame.height / CGFloat(rows)
        
        cellHeight -= 10
        cellWidth -= 10
        
        return CGSizeMake(cellWidth, cellHeight)
    }
}