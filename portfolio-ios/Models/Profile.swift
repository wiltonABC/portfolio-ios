//
//  Profile.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 03/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class Profile : Decodable {
    
    let idProfile : Int
    let name : String
    let shortName : String
    let mainActivity : String
    let about : String
    let image : String
    let email : String
    let address : String
    let address2 : String
    let city : String
    let stateProvince : String
    let postalCode : String
    let dateCreated : Date
    let dateModified : Date
    
    init(idProfile : Int, name : String, shortName : String, mainActivity : String, about : String,
         image : String, email : String, address : String, address2 : String, city : String,
         stateProvince : String, postalCode : String, dateCreated : Date, dateModified : Date ) {
        
        self.idProfile = idProfile
        self.name = name
        self.shortName = shortName
        self.mainActivity = mainActivity
        self.about = about
        self.image = image
        self.email = email
        self.address = address
        self.address2 = address2
        self.city = city
        self.stateProvince = stateProvince
        self.postalCode = postalCode
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        
    }
    
}
