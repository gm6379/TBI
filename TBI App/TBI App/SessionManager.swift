//
//  SessionManager.swift
//  TBI App
//
//  Created by George McDonnell on 16/02/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class SessionManager: NSObject {

    var currentSession: Session?
    
    static let sharedManager = SessionManager()
}
