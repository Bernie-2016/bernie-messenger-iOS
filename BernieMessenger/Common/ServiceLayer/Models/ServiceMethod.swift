//
//  ServiceMethod.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Alamofire

enum ServiceMethod {
    
    /// 'GET' HTTP method.
    case Get
    /// 'POST' HTTP method.
    case Post
    /// 'PUT' HTTP method.
    case Put
    /// 'DELETE' HTTP method.
    case Delete
    
    /// `Alamofire.Method` equivalent to be used by the Alamofire library.
    var alamofireMethod: Alamofire.Method {
        switch self {
        case .Get:
            return .GET
        case .Post:
            return .POST
        case .Put:
            return .PUT
        case .Delete:
            return .DELETE
        }
    }
    
}
