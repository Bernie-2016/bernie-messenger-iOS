//
//  AssignmentsBusinessService.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

class AssignmentsBusinessService {
    
    func fetchAssignments(completion: (ServiceResult<[Assignment]>) -> Void) {
        ServiceClient.requestWithEndpoint(AssignmentsEndpoint.FetchAssignments) {
            (result: ServiceResult<[Assignment]>) in
            
            completion(result)
        }
    }
    
    // TODO: Remove once real endpoint has assignments
    func fetchFakeAssignments(completion: (ServiceResult<[Assignment]>) -> Void) {
        let textActions1 = [TextAction(id: "asdf251", content: "Here's that link - registertovote.ca.gov"), TextAction(id: "gfdsg987", content: "Screw you, I'm defriending you on Facebook")]
        let assignment1 = Assignment(id: "h41234", expiration: NSDate(), name: "Register CA Voters", description: "It's time to register voters in California!", type: .CallAndText, instructions: "Calling is more effective than texting! Select a friend to call, then give them a call and do the thing in the script.", script: "Hi {{firstName}}, are you registered to vote in California?", textActions: textActions1)
        
        let textActions2 = [TextAction(id: "2jkh23", content: "Have you voted yet?")]
        let assignment2 = Assignment(id: "h41234", expiration: NSDate(), name: "Get Out the Vote in CA", description: "The primary is today! Get out the vote!", type: .Text, instructions: "Send a text to every single friend you can think of who can vote today in CA.", script: nil, textActions: textActions2)
        
        completion(.Success([assignment1, assignment2]))
    }
    
}
