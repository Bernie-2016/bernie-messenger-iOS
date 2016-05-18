//
//  PerformAssignmentTableViewController.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/11/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import AddressBookUI
import ContactsUI
import MessageUI
import UIKit

class PerformAssignmentTableViewController : TableViewController {
    
    private let assignment: Assignment
    private var selectedContact: Contact?
    private var selectedCallAction: CallAction?
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
        cell.configureCell(contact: nil, callAction: nil)
        cell.disabled = true
        return cell
    }()
    
    private lazy var textContactCell: PerformAssignmentTextContactTableViewCell = {
        let cell = PerformAssignmentTextContactTableViewCell.loadFromNib()
        cell.disabled = true
        return cell
    }()
    
    private lazy var errorCell: ErrorTableViewCell = {
        let cell = ErrorTableViewCell.loadFromNib()
        cell.errorText = "Unfortunately, your device cannot complete this assignment. Please try completing this assignment on a device that can call or text!"
        return cell
    }()
    
    private lazy var dataSource: [UITableViewCell] = {
        var dataSource = [self.infoCell, self.selectContactCell]
        if self.assignment.type.contains(.Call) && UIDevice.currentDevice().canMakeCalls() {
            dataSource.append(self.callContactCell)
        }
        if self.assignment.type.contains(.Text) && UIDevice.currentDevice().canSendTexts() {
            dataSource.append(self.textContactCell)
        }
        
        // Handle device that can't call or text
        if dataSource.count == 2 {
            return [self.infoCell, self.errorCell]
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
            showContactPicker()
            
        case self.callContactCell:
            if self.assignment.callActions.count > 1 {
                let actions: [ActionPickerable] = self.assignment.callActions.flatMap({ return $0 })
                showActionPicker(navigationTitle: "Call Actions", actions: actions)
                
            } else {
                didSelectCallAction(self.assignment.callActions.first!)
                if let indexPath = self.tableView.indexPathForCell(self.callContactCell) {
                    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
            }
            
        case self.textContactCell:
            if self.assignment.textActions.count > 1 {
                let actions: [ActionPickerable] = self.assignment.textActions.flatMap({ return $0 })
                showActionPicker(navigationTitle: "Text Actions", actions: actions)
                
            } else {
                didSelectTextAction(self.assignment.textActions.first!)
                if let indexPath = self.tableView.indexPathForCell(self.textContactCell) {
                    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
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
    
    private func showContactPicker() {
        if #available(iOS 9.0, *) {
            let contactPickerController = CNContactPickerViewController()
            contactPickerController.displayedPropertyKeys = [CNContactPhoneNumbersKey]
            contactPickerController.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
            contactPickerController.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
            contactPickerController.delegate = self
            presentViewController(contactPickerController, animated: true, completion: nil)
            
        } else {
            let peoplePickerController = ABPeoplePickerNavigationController()
            peoplePickerController.displayedProperties = [NSNumber(int: kABPersonPhoneProperty)]
            peoplePickerController.predicateForEnablingPerson = NSPredicate(format: "phoneNumbers.@count > 0")
            peoplePickerController.predicateForSelectionOfPerson = NSPredicate(format: "phoneNumbers.@count == 1")
            peoplePickerController.peoplePickerDelegate = self
            presentViewController(peoplePickerController, animated: true, completion: nil)
        }
    }
    
    private func didSelectContact(contact: Contact) {
        self.selectedContact = contact
        
        self.selectContactCell.configureCell(contact: contact)
        
        let callAction: CallAction? = self.assignment.callActions.count == 1 ? self.assignment.callActions.first! : nil
        self.callContactCell.configureCell(contact: contact, callAction: callAction)
        self.callContactCell.disabled = false
        self.callContactCell.isCompleted = false
        
        let textAction: TextAction? = self.assignment.textActions.count == 1 ? self.assignment.textActions.first! : nil
        self.textContactCell.configureCell(contact: contact, textAction: textAction)
        self.textContactCell.disabled = self.assignment.requireCallFirst && UIDevice.currentDevice().canMakeCalls()
        self.textContactCell.isCompleted = false
        
        self.tableView.update()
    }
    
    private func showActionPicker(navigationTitle navigationTitle: String, actions: [ActionPickerable]) {
        let actionPickerController = ActionPickerTableViewController(navigationTitle: navigationTitle, contact: self.selectedContact!, actions: actions)
        actionPickerController.delegate = self
        let pickerNavigationController = UINavigationController(rootViewController: actionPickerController)
        presentViewController(pickerNavigationController, animated: true, completion: nil)
    }
    
    private func didSelectCallAction(callAction: CallAction) {
        self.selectedCallAction = callAction
        self.callContactCell.configureCell(contact: self.selectedContact!, callAction: callAction)
        
        let phoneNumber = self.selectedContact!.phoneNumber
        let phoneNumberArray = phoneNumber.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        let strippedPhoneNumber = NSArray(array: phoneNumberArray).componentsJoinedByString("")
        
        let phoneNumberURL = "telprompt://" + strippedPhoneNumber
        UIApplication.sharedApplication().openURL(NSURL(string: phoneNumberURL)!)
        addCurrentAssignmentRecord(action: .Call)
        
        self.callContactCell.isCompleted = true
        self.textContactCell.disabled = false
        
        self.tableView.update()
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
        let selectedIndex = ABMultiValueGetIndexForIdentifier(phoneNumbers, identifier)
        let selectedPhoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, selectedIndex).takeRetainedValue() as! String
        
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: selectedPhoneNumber)
        didSelectContact(contact)
    }
    
    private func firstNameOfPerson(person: ABRecord) -> String {
        guard let personCopy = ABRecordCopyValue(person, kABPersonFirstNameProperty) else {
            return ""
        }
        return personCopy.takeRetainedValue() as? String ?? ""
    }
    
    private func lastNameOfPerson(person: ABRecord) -> String {
        guard let personCopy = ABRecordCopyValue(person, kABPersonLastNameProperty) else {
            return ""
        }
        return personCopy.takeRetainedValue() as? String ?? ""
    }
    
}

@available(iOS 9.0, *)
extension PerformAssignmentTableViewController : CNContactPickerDelegate {
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        let firstName = contact.givenName
        let lastName = contact.familyName
        guard let phoneNumber = contact.phoneNumbers.first?.value as? CNPhoneNumber else {
            // Should never reach here because of custom `predicateForEnablingPerson`
            return
        }
        
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber.stringValue)
        didSelectContact(contact)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let firstName = contactProperty.contact.givenName
        let lastName = contactProperty.contact.familyName
        guard let phoneNumber = contactProperty.value as? CNPhoneNumber else {
            // Should never reach here because of custom `predicateForEnablingPerson`
            return
        }
        
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber.stringValue)
        didSelectContact(contact)
    }
    
}

extension PerformAssignmentTableViewController : ActionPickerTableViewControllerDelegate {
    
    func actionPickerController(controller: ActionPickerTableViewController, didSelectAction action: ActionPickerable) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        switch action {
        case is CallAction:
            didSelectCallAction(action as! CallAction)
        case is TextAction:
            didSelectTextAction(action as! TextAction)
        default:
            break
        }
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
        case MessageComposeResultCancelled:
            controller.dismissViewControllerAnimated(true, completion: nil)
        default:
            break
        }
    }
    
}
