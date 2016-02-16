//
//  CoreDataManager.swift
//  TBI App
//
//  Created by George McDonnell on 16/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    // MARK: - Creation methods

    class func createUserWithUsername(username: String?) -> User {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext) as! User
        user.username = username
        
        appDelegate.saveContext()
        
        return user
    }
    
    class func createSessionWithUser(user: User) -> Session {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let session = NSEntityDescription.insertNewObjectForEntityForName("Session", inManagedObjectContext: appDelegate.managedObjectContext) as! Session
        session.startDate = NSDate()
        session.user = user
        
        appDelegate.saveContext()
        
        return session
    }
    
    class func createAnswerWithSession(session: Session, answerDictionary: Dictionary<String, String>) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let answer = NSEntityDescription.insertNewObjectForEntityForName("Answer", inManagedObjectContext: appDelegate.managedObjectContext) as! Answer
        answer.session = session
        
        let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(answerDictionary)
        answer.data = data
        answer.dateCreated = NSDate()
        
        appDelegate.saveContext()
    }
    
    // MARK: - Fetch methods
    
    class func fetchUserWithUsername(username: String) -> User? {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let request = NSFetchRequest(entityName: "User")
        request.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let results = try appDelegate.managedObjectContext.executeFetchRequest(request)
            if (results.count != 0) {
                return results.first! as? User
            } else {
                return nil
            }
        } catch {
            print(error)
        }

        return nil
    }

}
