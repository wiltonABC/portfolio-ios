//
//  MessageTextView.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 15/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class MessageTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
    }

}
