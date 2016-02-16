//
//  Session+CoreDataProperties.swift
//  TBI App
//
//  Created by George McDonnell on 16/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Session {

    @NSManaged var endDate: NSDate?
    @NSManaged var startDate: NSDate?
    @NSManaged var user: User?
    @NSManaged var answers: Answer?

}
