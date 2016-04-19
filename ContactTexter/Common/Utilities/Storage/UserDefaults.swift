//
//  UserDefaults.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/18/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

class UserDefaults {
    
    static let standardUserDefaults = UserDefaults(userDefaults: NSUserDefaults.standardUserDefaults())
    private let userDefaults: NSUserDefaults
    
    init(userDefaults: NSUserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func addAssignmentRecord(assignmentRecord: AssignmentRecord) {
        var assignmentHistory = self.assignmentHistory ?? [:]
        var records = assignmentHistory[assignmentRecord.assignmentId] ?? []
        
        records.append(assignmentRecord)
        assignmentHistory[assignmentRecord.assignmentId] = records
        self.assignmentHistory = assignmentHistory
    }
    
    func assignmentRecords(assignmentId assignmentId: String) -> [AssignmentRecord] {
        guard let assignmentHistory = self.assignmentHistory else {
            return []
        }
        
        return assignmentHistory[assignmentId] ?? []
    }
    
    var assignmentHistory: [String : [AssignmentRecord]]? {
        set {
            if let newValue = newValue {
                let data = NSKeyedArchiver.archivedDataWithRootObject(newValue)
                self.userDefaults.setObject(data, forKey: "assignmentHistory")
            } else {
                self.userDefaults.setObject(nil, forKey: "assignmentHistory")
            }
        }
        get {
            let data = self.userDefaults.objectForKey("assignmentHistory") as? NSData
            if let data = data {
                return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String : [AssignmentRecord]]
            } else {
                return nil
            }
        }
    }
    
}
