//
//  SkillsDataHandler.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class SkillsDataHandler {
    
    func getSkillsByCategory(skills : [Skill]) -> [SkillCategory] {
        var categories = Array<SkillCategory>()
        
        for skill in skills {
            if categories.first(where: { (skillCategory) -> Bool in
                skillCategory.idSkillCategory == skill.skillCategory.idSkillCategory
            }) == nil {
                categories.append(skill.skillCategory)
            }
        }
        
        for category in categories {
            category.skills = skills.filter({ (skill) -> Bool in
                skill.skillCategory.idSkillCategory == category.idSkillCategory
            })
        }
        
        return categories
        
    }
    
}
