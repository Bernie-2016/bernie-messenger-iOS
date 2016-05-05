//
//  AssignmentRecord.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/18/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

@objc(AssignmentRecord)
class AssignmentRecord : NSObject, NSCoding {
    
    let assignmentId: String
    let action: AssignmentRecordAction
    let contactName: String
    let recordDate: NSDate
    
    init(assignment: Assignment, action: AssignmentRecordAction, contact: Contact, recordDate: NSDate) {
        self.assignmentId = assignment.id
        self.action = action
        self.contactName = contact.fullName
        self.recordDate = recordDate
    }
    
    // MARK: NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        self.assignmentId = aDecoder.decodeObjectForKey("assignmentId") as! String
        let actionRawValue = aDecoder.decodeObjectForKey("action") as! String
        self.action = AssignmentRecordAction(rawValue: actionRawValue) ?? .Text
        self.contactName = aDecoder.decodeObjectForKey("contactName") as! String
        self.recordDate = aDecoder.decodeObjectForKey("recordDate") as! NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.assignmentId, forKey: "assignmentId")
        aCoder.encodeObject(self.action.rawValue, forKey: "action")
        aCoder.encodeObject(self.contactName, forKey: "contactName")
        aCoder.encodeObject(self.recordDate, forKey: "recordDate")
    }
    
}

enum AssignmentRecordAction : String {
    
    case Text = "Texted"
    case Call = "Called"
    
}
