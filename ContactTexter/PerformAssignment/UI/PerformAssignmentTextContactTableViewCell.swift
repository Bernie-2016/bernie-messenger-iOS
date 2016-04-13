//
//  PerformAssignmentTextContactTableViewCell.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/12/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentTextContactTableViewCell : UITableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var contactNameLabel: UILabel!
    
    func configureCell(contact contact: Contact) {
        self.contactNameLabel.text = "Text " + contact.firstName
    }
    
}
