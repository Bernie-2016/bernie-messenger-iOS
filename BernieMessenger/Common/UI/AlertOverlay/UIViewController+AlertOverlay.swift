//
//  UIViewController+AlertOverlay.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/18/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import PureLayout
import UIKit

extension UIViewController {
    
    func presentAlertMessageOverlay(alertMessage: AlertMessage, delay: NSTimeInterval = 0.0) {
        // Overlay needs to be constrained to the `UINavigationController`
        guard let navigationController = self.navigationController else {
            return
        }
        
        let alertOverlay = AlertOverlayView.loadFromNib()
        alertOverlay.translatesAutoresizingMaskIntoConstraints = false
        alertOverlay.configure(alertMessage: alertMessage)
        
        navigationController.view.insertSubview(alertOverlay, belowSubview: navigationController.navigationBar)
        alertOverlay.autoPinEdge(.Leading, toEdge: .Leading, ofView: navigationController.navigationBar)
        alertOverlay.autoPinEdge(.Trailing, toEdge: .Trailing, ofView: navigationController.navigationBar)
        
        animateOverlayDown(alertOverlay, navigationController: navigationController, forDurationToShow: 3.0, delay: delay)
    }
    
    // MARK: Animations
    
    private func animateOverlayDown(alertOverlay: AlertOverlayView, navigationController: UINavigationController, forDurationToShow durationToShow: NSTimeInterval, delay: NSTimeInterval) {
        // Position overlay in hidden position
        let hiddenConstraint = alertOverlay.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: navigationController.navigationBar)
        alertOverlay.layoutIfNeeded()
        
        // Remove hidden position and add desired showing position
        navigationController.view.removeConstraint(hiddenConstraint)
        let showingConstraint = alertOverlay.autoPinEdge(.Top, toEdge: .Bottom, ofView: navigationController.navigationBar)
        
        // Animate changes
        let animations = {
            alertOverlay.layoutIfNeeded()
        }
        let completion: (Bool) -> Void = { _ in
            self.animateOverlayUp(alertOverlay, navigationController: navigationController, showingConstraint: showingConstraint, forDurationToShow: durationToShow)
        }
        UIView.animateWithDuration(0.3, delay: delay, options: .CurveEaseOut, animations: animations, completion: completion)
    }
    
    private func animateOverlayUp(alertOverlay: AlertOverlayView, navigationController: UINavigationController, showingConstraint: NSLayoutConstraint, forDurationToShow durationToShow: NSTimeInterval) {
        // Remove showing position and add desired hiding position
        navigationController.view.removeConstraint(showingConstraint)
        let _ = alertOverlay.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: navigationController.navigationBar)
        
        // Animate changes
        let animations = {
            alertOverlay.layoutIfNeeded()
        }
        let completion: (Bool) -> Void = { _ in
            alertOverlay.removeFromSuperview()
        }
        UIView.animateWithDuration(0.3, delay: durationToShow, options: .CurveEaseOut, animations: animations, completion: completion)
    }
    
}
