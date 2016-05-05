//
//  AssignmentTableViewCell.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class AssignmentTableViewCell : UITableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var expirationLabel: UILabel!
    @IBOutlet private weak var nameLabel: MultilineLabel!
    
    func configureCell(assignment assignment: Assignment) {
        self.selectionStyle = .Default
        self.accessoryType = .DisclosureIndicator
        
        self.expirationLabel.text = assignment.expiration.expirationFormat
        self.nameLabel.text = assignment.name
    }
    
    func configureCell(assignmentRecord assignmentRecord: AssignmentRecord) {
        self.selectionStyle = .None
        self.accessoryType = .None
        
        self.expirationLabel.text = assignmentRecord.recordDate.historyFormat
        self.nameLabel.text = "\(assignmentRecord.action.rawValue) \(assignmentRecord.contactName)"
    }
    
}
