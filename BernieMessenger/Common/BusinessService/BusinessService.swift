//
//  BusinessService.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 5/15/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

protocol BusinessService : class {
    
    weak var uiDelegate: BusinessServiceUIDelegate? { get }
    
    init(uiDelegate: BusinessServiceUIDelegate?)
    
}
