//
//  LoginViewController.swift
//  TBI App
//
//  Created by George McDonnell on 10/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: OnBoardingStepViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = NSLocalizedString("Welcome", comment: "")
    }
    
    @IBAction func register(sender: UIButton) {
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            displayEmptyFieldError()
        } else {
            do {
                try SFHFKeychainUtils.storeUsername(usernameTextField.text, andPassword: passwordTextField.text, forServiceName: appName, updateExisting: true)
                let storedUser = CoreDataManager.fetchUserWithUsername(usernameTextField.text!)
                if (storedUser == nil) {
                    // create a new user in core data
                    let user = CoreDataManager.createUserWithUsername(usernameTextField.text)
                    
                    // start a new session for the user
                    let session = CoreDataManager.createSessionWithUser(user)
                    SessionManager.sharedManager.currentSession = session
                    
                    self.delegate?.didCompleteOnBoardingStep()
                } else {
                    displayUserExistsError()
                }
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func login(sender: UIButton) {
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            displayEmptyFieldError()
        } else {
            let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as? String
            do {
                let password = try SFHFKeychainUtils.getPasswordForUsername(usernameTextField.text, andServiceName: appName)
                if (passwordTextField.text == password) { // password is correct
                    // lookup user in core data
                    let user = CoreDataManager.fetchUserWithUsername(usernameTextField.text!)
                    if (user != nil) {
                        // start a new session for the user
                        let session = CoreDataManager.createSessionWithUser(user!)
                        
                        SessionManager.sharedManager.currentSession = session
                        
                        self.delegate?.didCompleteOnBoardingStep()
                    }
                } else { // password is incorrect
                    displayIncorrectPasswordError()
                }
            } catch { // user doesn't exist
                displayIncorrectUsernameError()
                print(error)
            }
        }
    }
    
    func displayEmptyFieldError() {
        let alert = UIAlertController(title: "Error", message: NSLocalizedString("Please enter a username and password", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayIncorrectUsernameError() {
        let alert = UIAlertController(title: "Error", message: NSLocalizedString("A user does not exist with that username", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayIncorrectPasswordError() {
        let alert = UIAlertController(title: "Error", message: NSLocalizedString("The password you entered is incorrect", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayUserExistsError() {
        let alert = UIAlertController(title: "Error", message: NSLocalizedString("User already exists", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}
