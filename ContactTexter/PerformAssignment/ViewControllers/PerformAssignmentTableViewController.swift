//
//  PerformAssignmentTableViewController.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import AddressBookUI
import MessageUI
import UIKit

class PerformAssignmentTableViewController : TableViewController {
    
    private let assignment: Assignment
    private var selectedContact: Contact?
    private var selectedTextAction: TextAction?
    
    private lazy var infoCell: PerformAssignmentInfoTableViewCell = {
        let cell = PerformAssignmentInfoTableViewCell.loadFromNib()
        cell.configureCell(assignment: self.assignment)
        return cell
    }()
    
    private lazy var selectContactCell: PerformAssignmentSelectContactTableViewCell = {
        return PerformAssignmentSelectContactTableViewCell.loadFromNib()
    }()
    
    private lazy var textContactCell: PerformAssignmentTextContactTableViewCell = {
        return PerformAssignmentTextContactTableViewCell.loadFromNib()
    }()
    
    private lazy var dataSource: [UITableViewCell] = {
        return [self.infoCell, self.selectContactCell, self.textContactCell]
    }()
    
    // MARK: Initializers
    
    init(assignment: Assignment) {
        self.assignment = assignment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 75.0
    }
    
    // MARK: ViewControllerType
    
    override var leftBarButtonItemType: LeftBarButtonItemType {
        return .Back
    }
    
    override var rightBarButtonItemType: RightBarButtonItemType {
        return .History
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedContact == nil {
            return 2
        } else {
            return 3
        }
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.dataSource[indexPath.row]
        return cell.calculatedHeight(tableView: tableView)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.dataSource[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.dataSource[indexPath.row]
        
        switch cell {
        case self.selectContactCell:
            let peoplePicker = ABPeoplePickerNavigationController()
            peoplePicker.displayedProperties = [NSNumber(int: kABPersonPhoneProperty)]
            peoplePicker.predicateForEnablingPerson = NSPredicate(format: "phoneNumbers.@count > 0")
            peoplePicker.predicateForSelectionOfPerson = NSPredicate(format: "phoneNumbers.@count == 1")
            peoplePicker.peoplePickerDelegate = self
            showViewController(peoplePicker, sender: nil)
            
        case self.textContactCell:
            let textActionPickerController = TextActionPickerTableViewController(textActions: self.assignment.textActions)
            textActionPickerController.delegate = self
            let pickerNavigationController = UINavigationController(rootViewController: textActionPickerController)
            presentViewController(pickerNavigationController, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    // MARK: Cell management
    
    private func didSelectContact(contact: Contact) {
        self.selectedContact = contact
        self.selectContactCell.configureCell(contact: contact)
        self.textContactCell.configureCell(contact: contact)
        
        self.tableView.reloadData()
    }
    
    private func didSelectTextAction(textAction: TextAction) {
        self.selectedTextAction = textAction
        
        let composeMessageController = MFMessageComposeViewController()
        composeMessageController.messageComposeDelegate = self
        composeMessageController.recipients = [self.selectedContact!.phoneNumber]
        composeMessageController.body = textAction.content
        presentViewController(composeMessageController, animated: true, completion: nil)
    }
    
}

// MARK: ABPeoplePickerNavigationControllerDelegate

extension PerformAssignmentTableViewController : ABPeoplePickerNavigationControllerDelegate {
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        let phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        guard ABMultiValueGetCount(phoneNumbers) > 0 else {
            // Should never reach here because of custom `predicateForEnablingPerson`
            return
        }
        
        let firstName = firstNameOfPerson(person)
        let lastName = lastNameOfPerson(person)
        let phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, 0 as CFIndex).takeRetainedValue() as! String
        
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        didSelectContact(contact)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        let firstName = firstNameOfPerson(person)
        let lastName = lastNameOfPerson(person)
        
        let phoneNumbers = ABRecordCopyValue(person, property).takeRetainedValue()
        let selectedIndex = ABMultiValueGetIndexForIdentifier(phoneNumbers, identifier);
        let selectedPhoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, selectedIndex).takeRetainedValue() as! String;
        
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: selectedPhoneNumber)
        didSelectContact(contact)
    }
    
    private func firstNameOfPerson(person: ABRecord) -> String {
        return ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? String ?? ""
    }
    
    private func lastNameOfPerson(person: ABRecord) -> String {
        return ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? String ?? ""
    }
    
}

extension PerformAssignmentTableViewController : TextActionPickerTableViewControllerDelegate {
    
    func textActionPickerController(controller: TextActionPickerTableViewController, didSelectTextAction textAction: TextAction) {
        didSelectTextAction(textAction)
    }
    
}

extension PerformAssignmentTableViewController : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result {
        case MessageComposeResultSent:
            print("Sent")
        case MessageComposeResultFailed:
            print("Failed")
        case MessageComposeResultCancelled:
            print("Cancelled")
        default:
            print("Unexpected")
        }
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
