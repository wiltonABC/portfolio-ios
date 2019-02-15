//
//  WorkDone.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 14/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class WorkDone : Decodable {

    let idWorkDone : Int32
    let name : String
    let image : String
    let description : String
    let dateCreated : Date
    let dateModified : Date
    
    init(idWorkDone : Int32, name : String, image : String, description : String, dateCreated : Date, dateModified : Date) {
        
        self.idWorkDone = idWorkDone
        self.name = name
        self.image = image
        self.description = description
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        
    }
}
