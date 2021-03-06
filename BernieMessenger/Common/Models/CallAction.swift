//
//  CallAction.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 5/14/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Freddy

struct CallAction {
    
    let id: Int
    let name: String
    let script: String
    
}

extension CallAction : JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.int("id")
        self.name = try json.string("name")
        self.script = try json.string("callScript")
    }
    
}

extension CallAction : ActionPickerable {
    
    var title: String {
        return self.name
    }
    
    var body: String {
        return self.script
    }
    
}
