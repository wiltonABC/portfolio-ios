//
//  Skill.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class Skill : Decodable {
    let idSkill : Int32
    let skillCategory : SkillCategory
    let name : String
    let dateCreated : Date
    
    init(idSkill : Int32, skillCategory : SkillCategory, name : String, dateCreated : Date) {
        
        self.idSkill = idSkill
        self.skillCategory = skillCategory
        self.name = name
        self.dateCreated = dateCreated
        
    }
}


