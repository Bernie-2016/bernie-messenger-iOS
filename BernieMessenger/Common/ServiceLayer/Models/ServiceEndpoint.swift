//
//  ServiceEndpoint.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

protocol ServiceEndpoint : ServiceRequest {
    
    /// Endpoint path relative to the `baseURL`.
    var resourcePath: String { get }
    
}

extension ServiceEndpoint {
    
    /// Creates the URL by appending `baseURL` and `resourcePath`.
    /// - SeeAlso: Declared on `ServiceRequest`.
    var URL: NSURL {
        let baseURL = NSURL(string: self.baseURL)!
        return NSURL(string: self.resourcePath, relativeToURL: baseURL)!
    }
    
    /// Host for endpoint.
    var baseURL: String {
        return "https://organize.berniesanders.com"
    }
    
}
