//
//  TitledTableViewCell.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class TitledTableViewCell : UITableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var titleLabel: MultilineLabel!
    @IBOutlet private weak var contentLabel: MultilineLabel!
    
    func configureCell(assignment assignment: Assignment) {
        self.selectionStyle = .Default
        self.accessoryType = .DisclosureIndicator
        
        self.titleLabel.text = assignment.expires.expirationFormat
        self.contentLabel.text = assignment.name
    }
    
    func configureCell(assignmentRecord assignmentRecord: AssignmentRecord) {
        self.selectionStyle = .None
        self.accessoryType = .None
        
        self.titleLabel.text = assignmentRecord.recordDate.historyFormat
        self.contentLabel.text = "\(assignmentRecord.action.rawValue) \(assignmentRecord.contactName)"
    }
    
    func configureCell(action action: ActionPickerable) {
        self.selectionStyle = .Default
        self.accessoryType = .None
        
        self.titleLabel.text = action.title
        self.contentLabel.text = action.body
    }
    
}
