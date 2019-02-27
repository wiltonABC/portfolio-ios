//
//  ContactViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 15/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet var contactName: UITextField!
    @IBOutlet var contactEmail: UITextField!
    @IBOutlet var contactSubject: UITextField!
    @IBOutlet var contactMessage: MessageTextView!
    
    @IBOutlet var formScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(resizeScrollViewForKeyboard(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
    }

    @IBAction func sendMessage(_ sender: UIButton) {
        if !formIsValid() {
            return
        }
        
        if let profile = (self.parent as! TabBarController).profile {
            let message = getFormData(profile: profile)
            ContactApiClient().sendMessage(message: message, success: { (statusCode) in
                if statusCode == 201 {
                    DispatchQueue.main.async {
                        self.clearForm()
                        DismissableAlertController(title: "", message: "Message successfully sent!", preferredStyle: .alert).showAndDismissAfter(presentingController: self, time: 1.5)
                    }
                } else {
                    DispatchQueue.main.async {
                        DismissableAlertController(title: "", message: "Your message could not be delivered!", preferredStyle: .alert).showAndDismissAfter(presentingController: self, time: 1.5)
                    }
                }
            }) { (error) in
                DispatchQueue.main.async {
                    DismissableAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert).showAndDismissAfter(presentingController: self, time: 1.5)
                }
            }
        }
    }
    
    func getFormData(profile : Profile) -> Message {
        let currentDateUnix = Date(timeIntervalSince1970: floor(Date().timeIntervalSince1970))
        let message = Message(idMessage : 0, profile: profile, name: contactName.text!, email: contactEmail.text!, subject: contactSubject.text!, message: contactMessage.text!, dateCreated: currentDateUnix)
        return message
    }
    
    func formIsValid() -> Bool {
        var message = ""
        var isValid = true
        
        let nameLength = contactName.text?.count ?? 0
        let emailLength = contactEmail.text?.count ?? 0
        let subjectLength = contactSubject.text?.count ?? 0
        let messageLength = contactMessage.text?.count ?? 0
        
        if nameLength == 0 {
            message += "Fill the name!\n"
            isValid = false
        } else {
            if nameLength > 40 {
                message += "The name must have up to 40 characters!\n"
                isValid = false
            }
        }
        
        if emailLength == 0 {
            message += "Fill the email!\n"
            isValid = false
        } else {
            if emailLength > 60 {
                message += "The email must have up to 60 characters!\n"
                isValid = false
            }
        }
        
        if subjectLength == 0 {
            message += "Fill the subject!\n"
            isValid = false
        } else {
            if subjectLength > 50 {
                message += "The subject must have up to 50 characters!\n"
                isValid = false
            }
        }
        
        if messageLength == 0 {
            message += "Fill the message!\n"
            isValid = false
        } else {
            if messageLength > 300 {
                message += "The message must have up to 300 characters!\n"
                isValid = false
            }
        }
        
        if message != ""{
            let alert = ValidationAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
        }
        
        return isValid
        
    }
    
    func clearForm() {
        contactName.text = ""
        contactEmail.text = ""
        contactSubject.text = ""
        contactMessage.text = ""
    }
    
    @objc func resizeScrollViewForKeyboard(notification : Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.formScroll.contentSize = CGSize(width: self.formScroll.frame.width, height: self.formScroll.frame.height + keyboardFrame.cgRectValue.height)
        }
        
    }

}
