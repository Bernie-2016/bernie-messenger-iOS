//
//  ErrorTableViewCell.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 5/17/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class ErrorTableViewCell : UITableViewCell, LoadableFromNib {
    
    @IBOutlet private weak var errorLabel: MultilineLabel!
    
    var errorText: String? {
        set {
            self.errorLabel.text = newValue
        }
        get {
            return self.errorLabel.text
        }
    }
    
}
