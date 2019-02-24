//
//  SkillTableViewSection.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class SkillTableViewSection: UITableViewCell {
    
    @IBOutlet var skillCategoryName: UILabel!
    @IBOutlet var skillCategoryImage: UIImageView!
    
    func setSkillCategorySectionData(category : SkillCategory) {
        skillCategoryName.text = category.name
        
        let baseUrl = Bundle.main.infoDictionary?["WEBAPI_ROOT_URL"] as! String
        self.skillCategoryImage.image = nil
        Imageloader().getImageFromUrl(baseUrl + "/\(category.image)", success: { (imageData) in
            DispatchQueue.main.async {
                self.skillCategoryImage.image = UIImage(data: imageData)
                self.skillCategoryImage.layer.cornerRadius = self.skillCategoryImage.frame.height/2
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
