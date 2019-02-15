//
//  WorkTableViewCell.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 14/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {
    
    @IBOutlet var workImage: UIImageView!
    @IBOutlet var workTitle: UILabel!
    @IBOutlet var workDescription: UILabel!
    
    
    func setWorkData(work : WorkDone) {
        self.workTitle.text = work.name
        self.workDescription.text = work.description
        let baseUrl = Bundle.main.infoDictionary?["WEBAPI_ROOT_URL"] as! String
        Imageloader().getImageFromUrl(baseUrl + "/\(work.image)", success: { (imageData) in
            DispatchQueue.main.async {
                self.workImage.image = UIImage(data: imageData)
            }
        }) { (error) in
            print(error)
        }
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
