//
//  ActionPickerTableViewController.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/12/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class ActionPickerTableViewController : TableViewController {
    
    private let navigationTitle: String
    private let contact: Contact
    private let actions: [ActionPickerable]
    
    private let dummyCell = TitledTableViewCell.loadFromNib()
    
    weak var delegate: ActionPickerTableViewControllerDelegate?
    
    // MARK: Initializers
    
    init(navigationTitle: String, contact: Contact, actions: [ActionPickerable]) {
        self.actions = actions
        self.contact = contact
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 75.0
        self.tableView.registerReusableCell(TitledTableViewCell.self)
    }
    
    // MARK: ViewControllerType
    
    override var titleType: NavigationItemTitleType {
        
        return .Text(title: self.navigationTitle)
    }
    
    override var rightBarButtonItemType: RightBarButtonItemType {
        return .Cancel
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actions.count
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        self.dummyCell.configureCell(contact: self.contact, action: self.actions[indexPath.row])
        return self.dummyCell.calculatedHeight(tableView: tableView)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TitledTableViewCell = self.tableView.dequeueReusableCell(indexPath)
        cell.configureCell(contact: self.contact, action: self.actions[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedAction = self.actions[indexPath.row]
        self.delegate?.actionPickerController(self, didSelectAction: selectedAction)
    }
    
}

protocol ActionPickerTableViewControllerDelegate : class {
    
    func actionPickerController(controller: ActionPickerTableViewController, didSelectAction action: ActionPickerable)
    
}

protocol ActionPickerable {
    
    var title: String { get }
    var body: String { get }
    
}
