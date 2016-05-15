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
    
    private lazy var callContactCell: PerformAssignmentCallContactTableViewCell = {
        let cell = PerformAssignmentCallContactTableViewCell.loadFromNib()
        cell.configureCell(callAction: nil)
        cell.disabled = true
        return cell
    }()
    
    private lazy var textContactCell: PerformAssignmentTextContactTableViewCell = {
        let cell = PerformAssignmentTextContactTableViewCell.loadFromNib()
        cell.disabled = true
        return cell
    }()
    
    private lazy var dataSource: [UITableViewCell] = {
        var dataSource = [self.infoCell, self.selectContactCell]
        if self.assignment.type.contains(.Call) {
            dataSource.append(self.callContactCell)
        }
        if self.assignment.type.contains(.Text) {
            dataSource.append(self.textContactCell)
        }
        return dataSource
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
        
        self.tableView.separatorStyle = .None
        self.tableView.estimatedRowHeight = 75.0
    }
    
    // MARK: ViewControllerType
    
    override var leftBarButtonItemType: LeftBarButtonItemType {
        return .Back
    }
    
    override var rightBarButtonItemType: RightBarButtonItemType {
        let historyButton = UIBarButtonItem(title: nil, style: .Plain, target: self, action: #selector(historyButtonAction))
        historyButton.setFAIcon(.FAHistory, iconSize: 20.0)
        return .Custom(historyButton)
    }
    
    // MARK: History button
    
    func historyButtonAction() {
        let assignmentRecords = UserDefaults.standardUserDefaults.assignmentRecords(assignmentId: self.assignment.id)
        let historyController = AssignmentsHistoryViewController(assignmentRecords: assignmentRecords)
        let navigationController = NavigationController(rootViewController: historyController)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
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
            
        case self.callContactCell:
            let phoneNumber = self.selectedContact!.phoneNumber
            let phoneNumberArray = phoneNumber.componentsSeparatedByCharactersInSet(
                NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let strippedPhoneNumber = NSArray(array: phoneNumberArray).componentsJoinedByString("")
            
            let phoneNumberURL = "telprompt://" + strippedPhoneNumber
            UIApplication.sharedApplication().openURL(NSURL(string: phoneNumberURL)!)
            addCurrentAssignmentRecord(action: .Call)
            
            self.callContactCell.isCompleted = true
            self.textContactCell.disabled = false
            
        case self.textContactCell:
            if self.assignment.textActions.count > 1 {
                let textActionPickerController = TextActionPickerTableViewController(textActions: self.assignment.textActions)
                textActionPickerController.delegate = self
                let pickerNavigationController = UINavigationController(rootViewController: textActionPickerController)
                presentViewController(pickerNavigationController, animated: true, completion: nil)
                
            } else {
                didSelectTextAction(self.assignment.textActions.first!)
            }
            
        default:
            break
        }
    }
    
    // MARK: Recording assignments
    
    private func addCurrentAssignmentRecord(action action: AssignmentRecordAction) {
        guard let selectedContact = self.selectedContact else {
            return
        }
        
        let record = AssignmentRecord(assignment: self.assignment, action: action, contact: selectedContact, recordDate: NSDate())
        UserDefaults.standardUserDefaults.addAssignmentRecord(record)
    }
    
    // MARK: Cell management
    
    private func didSelectContact(contact: Contact) {
        self.selectedContact = contact
        
        self.selectContactCell.configureCell(contact: contact)
        self.callContactCell.configureCell(contact: contact)
        self.callContactCell.disabled = false
        self.callContactCell.isCompleted = false
        self.textContactCell.configureCell(contact: contact)
        self.textContactCell.disabled = self.assignment.requireCallFirst
        self.textContactCell.isCompleted = false
    }
    
    private func didSelectTextAction(textAction: TextAction) {
        self.selectedTextAction = textAction
        
        let composeMessageController = MFMessageComposeViewController()
        composeMessageController.messageComposeDelegate = self
        composeMessageController.recipients = [self.selectedContact!.phoneNumber]
        composeMessageController.body = textAction.content
        presentViewController(composeMessageController, animated: true, completion: nil)
    }
    
    private func didSendTextMessage() {
        addCurrentAssignmentRecord(action: .Text)
        presentAlertMessageOverlay(.Success(message: "Message sent successfully. Keep contacting!"))
        self.navigationController?.popViewControllerAnimated(true)
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
        controller.dismissViewControllerAnimated(true, completion: nil)
        didSelectTextAction(textAction)
    }
    
}

extension PerformAssignmentTableViewController : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result {
        case MessageComposeResultSent:
            controller.dismissViewControllerAnimated(true, completion: nil)
            didSendTextMessage()
        case MessageComposeResultFailed:
            presentAlertMessageOverlay(.Error(message: "Sending text message failed. Try sending your text again!"))
        default:
            break
        }
    }
    
}
