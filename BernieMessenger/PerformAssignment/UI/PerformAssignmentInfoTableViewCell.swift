//
//  PerformAssignmentInfoTableViewCell.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentInfoTableViewCell : TableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var nameLabel: MultilineLabel!
    @IBOutlet private weak var descriptionLabel: MultilineLabel!
    @IBOutlet private weak var instructionsLabel: MultilineLabel!
    
    func configureCell(assignment assignment: Assignment) {
        self.nameLabel.text = assignment.name
        self.descriptionLabel.text = assignment.description
        self.instructionsLabel.text = assignment.instructions
        
        self.customSeparatorInset = UIEdgeInsetsZero
    }
    
}
