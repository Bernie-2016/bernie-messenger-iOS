//
//  PerformAssignmentTextActionPickerTableViewController.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/12/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class PerformAssignmentTextActionPickerTableViewController : TableViewController {
    
    private let textActions: [TextAction]
    weak var delegate: PerformAssignmentTextActionPickerTableViewControllerDelegate?
    
    // MARK: Initializers
    
    init(textActions: [TextAction]) {
        self.textActions = textActions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerReusableCell(UITableViewCell.self)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.textActions.count
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(indexPath)
        cell.textLabel?.text = self.textActions[indexPath.row].content
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedTextAction = self.textActions[indexPath.row]
        self.delegate?.textActionPickerController(self, didSelectTextAction: selectedTextAction)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}

protocol PerformAssignmentTextActionPickerTableViewControllerDelegate : class {
    
    func textActionPickerController(controller: PerformAssignmentTextActionPickerTableViewController, didSelectTextAction textAction: TextAction)
    
}
