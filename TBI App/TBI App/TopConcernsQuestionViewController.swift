//
//  SelectedConernsViewController.swift
//  TBI App
//
//  Created by George McDonnell on 04/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class TopConcernsQuestionViewController: QuestionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    let datasource = ["", "", "", ""]

}

extension TopConcernsQuestionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var itemsPerRow = 0
        if (datasource.count <= 2) {
            itemsPerRow = 1
        } else if (datasource.count < 7) {
            itemsPerRow = 2
        } else if (datasource.count < 13) {
            itemsPerRow = 3
        } else {
            itemsPerRow = 4
        }
        
        let remainder = datasource.count % itemsPerRow
        var cellWidth : CGFloat = 0
        
        // if the index path is within the remainder, divide by that instead of the constant
        if datasource.count - indexPath.item <= remainder {
            cellWidth = (collectionView.frame.width / CGFloat(remainder))
        }
        else {
            cellWidth = (collectionView.frame.width / CGFloat(itemsPerRow))
        }
        
        var rows = datasource.count / Int(itemsPerRow)
        if datasource.count % Int(itemsPerRow) >= 1 {
            rows += 1
        }
        
        var cellHeight = collectionView.frame.height / CGFloat(rows)
        
        cellHeight -= 10
        cellWidth -= 10
        
        return CGSizeMake(cellWidth, cellHeight)
    }
}