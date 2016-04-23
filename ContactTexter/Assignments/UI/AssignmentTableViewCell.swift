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
        self.expirationLabel.text = assignment.expiration.description // TODO: Format this pretty
        self.nameLabel.text = assignment.name
    }
    
    func configureCell(assignmentRecord assignmentRecord: AssignmentRecord) {
        self.expirationLabel.text = assignmentRecord.recordDate.description // TODO: Format this pretty
        self.nameLabel.text = assignmentRecord.contactName
    }
    
}
