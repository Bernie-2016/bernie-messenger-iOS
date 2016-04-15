//
//  PerformAssignmentCallContactTableViewCell.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/14/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentCallContactTableViewCell : TableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var phoneIconLabel: UILabel!
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var scriptLabel: UILabel!
    
    var isCompleted: Bool = false {
        didSet {
            self.phoneIconLabel.textColor = self.isCompleted ? UIColor.success() : UIColor.incomplete()
        }
    }
    
    func configureCell(assignment assignment: Assignment) {
        self.scriptLabel.text = assignment.script
    }
    
    func configureCell(contact contact: Contact) {
        self.contactNameLabel.text = "Call " + contact.firstName
        self.scriptLabel.text = self.scriptLabel.text?.stringByReplacingOccurrencesOfString("{{firstName}}", withString: contact.firstName)
    }
    
    override func awakeFromNib() {
        self.phoneIconLabel.setFAIcon(.FAPhone, iconSize: 20.0)
        self.phoneIconLabel.textColor = UIColor.incomplete()
    }
    
}
