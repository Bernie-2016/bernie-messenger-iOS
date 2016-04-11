//
//  ServiceEmptyResponse.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Freddy

// Special object that can be used when you don't care about 
// the response payload and only care about 200 or API error.
struct ServiceEmptyResponse {
    
}

extension ServiceEmptyResponse : JSONDecodable {
    
    init(json: JSON) throws {
        // No properties to map
    }
    
}
