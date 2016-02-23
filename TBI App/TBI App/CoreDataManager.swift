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
    
    class func createAnswer(questionType: String, answerDictionary: Dictionary<String, AnyObject>) {
        let session = SessionManager.sharedManager.currentSession
        let identifier: String = (session?.objectID.description)! + questionType
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let answer = NSEntityDescription.insertNewObjectForEntityForName("Answer", inManagedObjectContext: appDelegate.managedObjectContext) as! Answer
        answer.identifier = identifier
        answer.session = session
        let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(answerDictionary)
        answer.data = data
        answer.dateCreated = NSDate()
        
        appDelegate.saveContext()
    }
    
    // MARK: - Update methods
    
    class func updateAnswer(answer: Answer, withAnswerDictionary answerDictionary: Dictionary<String, AnyObject>) {
        let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(answerDictionary)
        answer.data = data
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveContext()
    }
    
    // MARK: - Fetch methods
    
    class func fetchUserWithUsername(username: String) -> User? {
        let request = NSFetchRequest(entityName: "User")
        request.predicate = NSPredicate(format: "username == %@", username)
        request.fetchLimit = 1
        
        if let results = fetchResultsForRequest(request) {
            return results.first as? User
        } else {
            return nil
        }
            
    }
    
    class func fetchAnswerFromQuestionType(questionType: String) -> Answer? {
        let sessionId = SessionManager.sharedManager.currentSession?.objectID
        let identifier: String = (sessionId?.description)! + questionType
        
        let request = NSFetchRequest(entityName: "Answer")
        request.predicate = NSPredicate(format: "identifier == %@", identifier)
        request.fetchLimit = 1
        
        if let results = fetchResultsForRequest(request) {
            return results.first as? Answer
        } else {
            return nil
        }
    }
    
    // queries answer entity for areas of concern answers for current session
    class func fetchAreaOfConcernAnswers() -> [Answer]? {
        let sessionId = SessionManager.sharedManager.currentSession?.objectID.description
        let request = NSFetchRequest(entityName: "Answer")
        
        let currentSessionPredicate = NSPredicate(format: "identifier contains[c] %@", sessionId!)
        let areaOfConcernPredicate = NSPredicate(format: "identifier contains[c] %@", "AreaOfConcern")
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [currentSessionPredicate, areaOfConcernPredicate])
        
        if let results = fetchResultsForRequest(request) {
            return results as? [Answer]
        } else {
            return nil
        }
    }
    
    class func fetchResultsForRequest(request: NSFetchRequest) -> [AnyObject]? {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        do {
            let results = try appDelegate.managedObjectContext.executeFetchRequest(request)
            return results
        } catch {
            print(error)
        }
        
        return nil
    }
    
    // MARK: - Export methods
    
    class func export() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let request = NSFetchRequest(entityName: "Answer")
        do {
            let results = try appDelegate.managedObjectContext.executeFetchRequest(request)
            for result in results {
                let answer = result as! Answer
                let identifier = answer.identifier
                let user = answer.session!.user!.username
                let dateCreated = answer.dateCreated?.description
                
                let answerData = NSKeyedUnarchiver.unarchiveObjectWithData(answer.data!)
                
                let data: Dictionary<String, AnyObject> = ["identifier" : identifier!, "answerData" : answerData!, "user" : user!, "dateCreated" : dateCreated!]
                print(data)
            }
        } catch {
            print(error)
        }
    }
}
