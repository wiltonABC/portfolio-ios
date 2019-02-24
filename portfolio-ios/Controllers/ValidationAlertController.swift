//
//  ValidationAlertViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 17/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class ValidationAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let messageColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        
        if let message = self.message {
            
            let attributedMessageString = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : messageColor])
            self.setValue(attributedMessageString, forKey: "attributedMessage")
            
        }
        
        if let title = self.title {
            let attributedTitleString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : messageColor])
            self.setValue(attributedTitleString, forKey: "attributedTitle")
        }
        
        self.view.tintColor = messageColor
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        self.addAction(okAction)
    }

}
