//
//  SkillCategory.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class SkillCategory : Decodable {
    let idSkillCategory : Int32
    let name : String
    let image : String
    let dateCreated : Date
    var skills : [Skill]?
    
    init(idSkillCategory : Int32, name : String, image : String, dateCreated : Date) {
        
        self.idSkillCategory = idSkillCategory
        self.name = name
        self.image = image
        self.dateCreated = dateCreated
        
    }
    
    enum CodingKeys : String, CodingKey {
        case idSkillCategory
        case name
        case image
        case dateCreated
    }
}
