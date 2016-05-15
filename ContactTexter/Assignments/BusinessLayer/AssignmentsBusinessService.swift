//
//  AssignmentsBusinessService.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

class AssignmentsBusinessService : BusinessService {
    
    weak var uiDelegate: BusinessServiceUIDelegate?
    
    required init(uiDelegate: BusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
    }
    
    func fetchAssignments(completion: (ServiceResult<[Assignment]>) -> Void) {
        self.uiDelegate?.willPerformBlockingCall(loadingMessage: "Loading assignments...", businessService: self)
        ServiceClient.requestWithEndpoint(AssignmentsEndpoint.FetchAssignments) {
            (result: ServiceResult<[Assignment]>) in
            
            self.uiDelegate?.didFinishBlockingCall(businessService: self)
            completion(result)
        }
    }
    
}
