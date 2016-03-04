//
//  SetupViewController.swift
//  TBI App
//
//  Created by George McDonnell on 04/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLAuthScopeDrive]
    
    private let service = GTLServiceDrive()
    
    // and initialize the Drive API service
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(
            Constants.kKeychainItemName,
            clientID: Constants.kClientID,
            clientSecret: nil) {
                service.authorizer = auth
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if let authorizer = service.authorizer,
            canAuth = authorizer.canAuthorize where canAuth {
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    CoreDataManager.export(self.service.authorizer as! GTMOAuth2Authentication)
                })
        } else {
            presentViewController(
                createAuthController(),
                animated: true,
                completion: nil
            )
        }
    }


    // Creates the auth controller for authorizing access to Drive API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = scopes.joinWithSeparator(" ")
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: Constants.kClientID,
            clientSecret: nil,
            keychainItemName: Constants.kKeychainItemName,
            delegate: self,
            finishedSelector: "viewController:finishedWithAuth:error:"
        )
    }
    
    // Handle completion of the authorization process, and update the Drive API
    // with the new credentials.
    func viewController(vc : UIViewController,
        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
            
            if let error = error {
                service.authorizer = nil
                showAlert("Authentication Error", message: error.localizedDescription)
                return
            }
            
            service.authorizer = authResult
            dismissViewControllerAnimated(false, completion: nil)
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
