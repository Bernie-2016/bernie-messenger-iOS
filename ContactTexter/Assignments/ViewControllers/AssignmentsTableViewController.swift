//
//  AssignmentsTableViewController.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class AssignmentsTableViewController : TableViewController {
    
    private var assignments: [Assignment] = []
    
    private lazy var dummyAssignmentCell = AssignmentTableViewCell.loadFromNib()
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.registerReusableCell(AssignmentTableViewCell.self)
        
        let businessService = AssignmentsBusinessService()
        businessService.fetchFakeAssignments {
            (result: ServiceResult<[Assignment]>) in
            
            switch result {
            case .Success(let assignments):
                self.assignments = assignments
                self.tableView.reloadData()
                
            case .Failure(_):
                // Do error things
                break
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assignments.count
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AssignmentTableViewCell = tableView.dequeueReusableCell(indexPath)
        cell.configureCell(assignment: self.assignments[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        self.dummyAssignmentCell.configureCell(assignment: self.assignments[indexPath.row])
        return self.dummyAssignmentCell.calculatedHeight(tableView: tableView)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let assignment = self.assignments[indexPath.row]
        let controller = PerformAssignmentTableViewController(assignment: assignment)
        showViewController(controller, sender: nil)
    }
    
}
