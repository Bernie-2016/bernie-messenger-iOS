//
//  AlertOverlayView.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/18/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class AlertOverlayView : UIView, LoadableFromNib {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var messageLabel: MultilineLabel!
    @IBOutlet private weak var dividerView: UIView!
    
    // MARK: Public
    
    func configure(alertMessage alertMessage: AlertMessage) {
        self.messageLabel.text = alertMessage.message
        self.dividerView.backgroundColor = alertMessage.foregroundColor
        self.backgroundColor = alertMessage.backgroundColor
    }
    
}

enum AlertMessage {
    
    case Success(message: String)
    case Error(message: String)
    
    var message: String {
        switch self {
        case .Success(let message):
            return message
        case .Error(let message):
            return message
        }
    }
    
    var foregroundColor: UIColor {
        switch self {
        case .Success:
            return UIColor.success()
        case .Error:
            return UIColor.error()
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .Success:
            return UIColor.successBackground()
        case .Error:
            return UIColor.errorBackground()
        }
    }
    
}
