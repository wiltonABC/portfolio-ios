//
//  SkillTableViewCell.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    @IBOutlet var skillLabel: UILabel!
    
    func setSkillData(skill : Skill) {
        skillLabel.text = skill.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
