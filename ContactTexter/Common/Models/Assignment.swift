//
//  Assignment.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation
import Freddy

struct Assignment {
    
    let id: String
    let expiration: NSDate
    
    let name: String
    let description: String
    let type: AssignmentType
    
    let instructions: String
    let script: String?
    let textActions: [TextAction]
    
}

extension Assignment : JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.string("id")
        self.expiration = NSDate() // TODO: Use date from service call
        
        self.name = try json.string("name")
        self.description = try json.string("description")
        self.type = try json.decode("type")
        
        self.instructions = try json.string("instructions")
        self.script = try json.string("script")
        self.textActions = try json.arrayOf("textActions")
    }
    
}

enum AssignmentType : String, JSONDecodable {
    
    case Text = "text"
    case CallAndText = "call-and-text"
    
}
