//
//  TextAction.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Freddy

struct TextAction {
    
    let id: String
    let content: String
    
}

extension TextAction : JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.string("id")
        self.content = try json.string("content")
    }
    
}
