//
//  PerformAssignmentTextContactTableViewCell.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/12/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentTextContactTableViewCell : TableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var textIconLabel: UILabel!
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var textContentLabel: MultilineLabel!
    
    var isCompleted: Bool = false {
        didSet {
            self.textIconLabel.textColor = self.isCompleted ? UIColor.success() : UIColor.incomplete()
        }
    }
    
    func configureCell(contact contact: Contact?, textAction: TextAction?) {
        let firstName = contact?.firstName ?? "Contact"
        let script = textAction?.content ?? "Select a text message"
        
        self.contactNameLabel.text = "Text \(firstName)"
        self.textContentLabel.text = script.stringByReplacingOccurrencesOfString("{{contact.firstName}}", withString: firstName)
    }
    
    override func awakeFromNib() {
        self.textIconLabel.setFAIcon(.FAComment, iconSize: 20.0)
        self.textIconLabel.textColor = UIColor.incomplete()
    }
    
}
