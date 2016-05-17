//
//  Assignment.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation
import Freddy

struct Assignment {
    
    let id: Int
    let name: String
    let description: String
    let expires: NSDate
    
    let requireCallFirst: Bool
    let instructions: String
    let callActions: [CallAction]
    let textActions: [TextAction]
    
    var type: AssignmentType {
        var assignmentType: AssignmentType = []
        if !self.callActions.isEmpty {
            assignmentType.insert(.Call)
        }
        if !self.textActions.isEmpty {
            assignmentType.insert(.Text)
        }
        return assignmentType
    }
    
}

extension Assignment : JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.int("id")
        self.name = try json.string("name")
        self.description = try json.string("description")
        self.expires = NSDate(fromString: try json.string("expires")) ?? NSDate()
        
        self.requireCallFirst = try json.bool("requireCallFirst")
        self.instructions = try json.string("instructions")
        self.callActions = try json.arrayOf("callActions")
        self.textActions = try json.arrayOf("textActions")
    }
    
}
