//
//  Contact.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/12/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

struct Contact {
    
    let firstName: String
    let lastName: String
    let phoneNumber: String
    
    var fullName: String {
        return self.firstName + " " + self.lastName
    }
    
}
