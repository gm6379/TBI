//
//  Answer+CoreDataProperties.swift
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

extension Answer {

    @NSManaged var data: NSData?
    @NSManaged var session: Session?

}
