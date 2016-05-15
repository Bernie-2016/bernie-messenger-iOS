//
//  BusinessService.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 5/15/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

protocol BusinessService : class {
    
    /// Optional delegate to handle UI updates
    weak var uiDelegate: BusinessServiceUIDelegate? { get }
    
    /**
     Initialize a `BusinessService` protocol based object
     
     - parameter uiDelegate: Optional delegate to handle UI updates
     
     - returns: The initialized business service object
     */
    init(uiDelegate: BusinessServiceUIDelegate?)
    
}
