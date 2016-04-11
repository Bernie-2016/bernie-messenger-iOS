//
//  ServiceRequest.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Alamofire

protocol ServiceRequest : URLRequestConvertible {
    
    /// The HTTP method.
    var method: ServiceMethod { get }
    /// The URL request.
    var URL: NSURL { get }
    
    /// Parameters to include in the request payload.
    var parameters: [String : AnyObject]? { get }
    /// Specifies how the parameters are applied to the request.
    var parametersEncoding: ParameterEncoding { get }
    
    /// Additional headers to include on a request.
    var customHeaders: [String : String]? { get }
    
    /// Time in seconds until a request should timeout.
    var timeout: Double { get }
    
}

extension ServiceRequest {
    
    // MARK: Parameters
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    var parametersEncoding: ParameterEncoding {
        return .JSON
    }
    
    // MARK: Headers
    
    var customHeaders: [String : String]? {
        return nil
    }
    
    // MARK: Other
    
    var timeout: Double {
        return 30.0
    }
    
}

// MARK: URLRequestConvertible

extension ServiceRequest {
    
    var URLRequest: NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: self.URL, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: self.timeout)
        mutableURLRequest.HTTPMethod = self.method.alamofireMethod.rawValue
        
        if let headers = self.customHeaders {
            for (headerField, headerValue) in headers {
                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        let (URLRequest, _) = self.parametersEncoding.encode(mutableURLRequest, parameters: self.parameters)
        return URLRequest
    }
    
}
