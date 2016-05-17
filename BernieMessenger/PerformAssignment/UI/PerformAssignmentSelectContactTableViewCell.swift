//
//  PerformAssignmentSelectContactTableViewCell.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentSelectContactTableViewCell : TableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var addIconLabel: UILabel!
    @IBOutlet private weak var contactNameLabel: UILabel!
    
    func configureCell(contact contact: Contact) {
        self.contactNameLabel.text = contact.fullName
        self.addIconLabel.textColor = UIColor.success()
    }
    
    override func awakeFromNib() {
        self.addIconLabel.setFAIcon(.FAUserPlus, iconSize: 20.0)
        self.addIconLabel.textColor = UIColor.incomplete()
    }
    
}
