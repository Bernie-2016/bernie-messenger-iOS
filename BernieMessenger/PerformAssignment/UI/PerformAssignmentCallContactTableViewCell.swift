//
//  PerformAssignmentCallContactTableViewCell.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/14/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentCallContactTableViewCell : TableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var phoneIconLabel: UILabel!
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var scriptLabel: MultilineLabel!
    
    var isCompleted: Bool = false {
        didSet {
            self.phoneIconLabel.textColor = self.isCompleted ? UIColor.success() : UIColor.incomplete()
        }
    }
    
    func configureCell(contact contact: Contact?, callAction: CallAction?) {
        let firstName = contact?.firstName ?? "Contact"
        let script = callAction?.script ?? "Select a script"
        
        self.contactNameLabel.text = "Call \(firstName)"
        self.scriptLabel.text = script.stringByReplacingOccurrencesOfString("{{contact.firstName}}", withString: firstName)
    }
    
    override func awakeFromNib() {
        self.phoneIconLabel.setFAIcon(.FAPhone, iconSize: 20.0)
        self.phoneIconLabel.textColor = UIColor.incomplete()
    }
    
}
