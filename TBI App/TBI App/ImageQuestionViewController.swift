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
    
}
