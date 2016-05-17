//
//  AlertOverlayView.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/18/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Font_Awesome_Swift
import UIKit

class AlertOverlayView : UIView, LoadableFromNib {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var iconLabel: UILabel!
    @IBOutlet private weak var messageLabel: MultilineLabel!
    @IBOutlet private weak var dividerView: UIView!
    
    // MARK: Public
    
    func configure(alertMessage alertMessage: AlertMessage) {
        self.iconLabel.setFAIcon(alertMessage.icon, iconSize: 15.0)
        self.iconLabel.textColor = alertMessage.foregroundColor
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
    
    var icon: FAType {
        switch self {
        case .Success:
            return .FACheckCircle
        case .Error:
            return .FAExclamationCircle
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
