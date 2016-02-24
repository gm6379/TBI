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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        options = question?.options
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let imageView = UIImageView(frame: cell.bounds)
        let imageName = options!["option" + String(indexPath.item + 1)]!["image"] as! String
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.addSubview(imageView)
        
        return cell
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