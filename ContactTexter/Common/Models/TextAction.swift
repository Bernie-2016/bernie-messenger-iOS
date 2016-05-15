//
//  TextAction.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Freddy

struct TextAction {
    
    let id: Int
    let name: String
    let content: String
    
}

extension TextAction : JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.int("id")
        self.name = try json.string("name")
        self.content = try json.string("messageContent")
    }
    
}

extension TextAction : ActionPickerable {
    
    var title: String {
        return self.name
    }
    
    var body: String {
        return self.content
    }
    
}
