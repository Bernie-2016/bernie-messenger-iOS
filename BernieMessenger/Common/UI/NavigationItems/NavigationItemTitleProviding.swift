//
//  NavigationItemTitleProviding.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/13/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

enum NavigationItemTitleType {
    
    case None
    case BernieLogo
    case Text(title: String)
    
}

protocol NavigationItemTitleProviding : class {
    
    var titleType: NavigationItemTitleType { get }
    
}

extension NavigationItemTitleProviding where Self : UIViewController {
    
    func setUpNavigiationItemTitle() {
        self.navigationItem.titleView = nil
        
        switch self.titleType {
        case .None:
            break
            
        case .BernieLogo:
            self.navigationItem.titleView = createBernieLogoImageView()
            
        case .Text(let title):
            let titleLabel = createTitleLabel(title: title)
            self.navigationItem.titleView = titleLabel
            titleLabel.sizeToFit()
        }
    }
    
    private func createBernieLogoImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100.0, height: 35.0))
        imageView.image = UIImage(named: "bernie_logo")?.imageWithRenderingMode(.AlwaysTemplate)
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }
    
    private func createTitleLabel(title title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.accessibilityLabel = title
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = .Center
        return titleLabel
    }
    
}
