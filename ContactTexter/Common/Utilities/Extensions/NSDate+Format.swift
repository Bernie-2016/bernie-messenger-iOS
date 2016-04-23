//
//  NSDate+Format.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/22/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Foundation

extension NSDate {
    
    var expirationFormat: String {
        let calendar = NSCalendar.currentCalendar()
        if calendar.isDateInToday(self) {
            return "Expires today"
        } else if calendar.isDateInTomorrow(self) {
            return "Expires tomorrow"
        } else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMMM dd"
            return "Expires " + dateFormatter.stringFromDate(self)
        }
    }
    
    var historyFormat: String {
        let calendar = NSCalendar.currentCalendar()
        if calendar.isDateInToday(self) {
            return "Completed today"
        } else if calendar.isDateInYesterday(self) {
            return "Completed yesterday"
        } else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMMM dd"
            return "Completed " + dateFormatter.stringFromDate(self)
        }
    }
    
}
