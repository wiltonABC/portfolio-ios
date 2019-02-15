//
//  SkillTableViewSection.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class SkillTableViewSection: UIView {

    @IBOutlet var skillCategoryImage: UIImageView!
    @IBOutlet var skillCategoryName: UILabel!
    
    
    func setSkillCategorySectionData(category : SkillCategory) {
        skillCategoryName.text = category.name
        
        let baseUrl = Bundle.main.infoDictionary?["WEBAPI_ROOT_URL"] as! String
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
