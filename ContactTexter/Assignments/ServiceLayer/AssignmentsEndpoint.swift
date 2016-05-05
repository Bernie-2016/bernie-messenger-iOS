//
//  AssignmentsEndpoint.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 5/4/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

enum AssignmentsEndpoint {
    
    case FetchAssignments
    
}

extension AssignmentsEndpoint : ServiceEndpoint {
    
    var method: ServiceMethod {
        return .Get
    }
    
    var resourcePath: String {
        return "contact-assignments.json"
    }
    
}
