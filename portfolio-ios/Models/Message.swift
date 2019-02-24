//
//  Message.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 16/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class Message : Encodable {
    let idMessage : Int32
    let profile : Profile
    let name : String
    let email : String
    let subject : String
    let message : String
    let dateCreated : Date
    
    init(idMessage : Int32, profile : Profile, name : String, email : String, subject : String, message : String, dateCreated : Date) {

        self.idMessage = idMessage
        self.profile = profile
        self.name = name
        self.email = email
        self.subject = subject
        self.message = message
        self.dateCreated = dateCreated
    }
}
