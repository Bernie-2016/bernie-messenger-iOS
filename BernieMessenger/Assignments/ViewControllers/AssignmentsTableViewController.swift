//
//  AssignmentsTableViewController.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class AssignmentsTableViewController : TableViewController {
    
    private var assignments: [Assignment] = []
    private var showErrorCell: Bool = false
    
    private lazy var dummyAssignmentCell = TitledTableViewCell.loadFromNib()
    
    private lazy var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), forControlEvents: .ValueChanged)
        return refreshControl
    }()
    
    private lazy var errorCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = UIColor.body()
        cell.textLabel?.font = UIFont.systemFontOfSize(17.0)
        cell.textLabel?.numberOfLines = 0
        return cell
    }()
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 75.0
        self.tableView.registerReusableCell(TitledTableViewCell.self)
        self.tableView.tableFooterView = UIView()
        self.refreshControl = self.pullToRefreshControl
        
        fetchAssignments()
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showErrorCell ? 1 : self.assignments.count
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.showErrorCell {
            return self.errorCell
            
        } else {
            let cell: TitledTableViewCell = tableView.dequeueReusableCell(indexPath)
            cell.configureCell(assignment: self.assignments[indexPath.row])
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.showErrorCell {
            return self.errorCell.calculatedHeight(tableView: tableView)
            
        } else {
            self.dummyAssignmentCell.configureCell(assignment: self.assignments[indexPath.row])
            return self.dummyAssignmentCell.calculatedHeight(tableView: tableView)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let assignment = self.assignments[indexPath.row]
        let controller = PerformAssignmentTableViewController(assignment: assignment)
        showViewController(controller, sender: nil)
    }
    
    // MARK: Service calls
    
    private func fetchAssignments() {
        let businessService = AssignmentsBusinessService(uiDelegate: self)
        businessService.fetchAssignments {
            (result: ServiceResult<[Assignment]>) in
            
            switch result {
            case .Success(let assignments):
                self.assignments = assignments
                self.showErrorCell = assignments.isEmpty
                if assignments.isEmpty {
                    self.errorCell.textLabel?.text = "There aren't any available assignments at this time. Please check again later."
                }
                
            case .Failure(_):
                self.errorCell.textLabel?.text = "There was a problem loading the assignments. Make sure you're connected to the Internet."
                self.showErrorCell = true
            }
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc private func didPullToRefresh() {
        fetchAssignments()
    }
    
}
