//
//  AssignmentsTableViewController.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class AssignmentsTableViewController : TableViewController {
    
    private lazy var dummyAssignmentCell = AssignmentTableViewCell.loadFromNib()
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.registerReusableCell(AssignmentTableViewCell.self)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AssignmentTableViewCell = tableView.dequeueReusableCell(indexPath)
        // TODO: Configure cell with assignment data
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // TODO: Configure dummy cell with assignment data
        return self.dummyAssignmentCell.calculatedHeight(tableView: tableView)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: Go to assignment details page
    }
    
}
