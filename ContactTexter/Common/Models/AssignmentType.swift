//
//  AssignmentType.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 5/4/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Freddy

enum AssignmentType : String {
    
    case Text = "text"
    case CallAndText = "call-and-text"
    
}

extension AssignmentType : JSONDecodable { }
