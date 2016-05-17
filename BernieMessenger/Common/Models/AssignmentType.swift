//
//  AssignmentType.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 5/4/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Freddy

struct AssignmentType : OptionSetType {
    
    let rawValue: Int
    
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // MARK: Options
    
    static let Call = AssignmentType(rawValue: 1)
    static let Text = AssignmentType(rawValue: 2)
    
}

extension AssignmentType : JSONDecodable { }
