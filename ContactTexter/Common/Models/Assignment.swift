//
//  Assignment.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

struct Assignment {
    
    let id: String
    let expiration: NSDate
    
    let name: String
    let description: String
    let type: AssignmentType
    
    let instructions: String
    let script: String
    
}

enum AssignmentType : String {
    
    case Text = "text"
    case CallAndText = "call-and-text"
    
}
