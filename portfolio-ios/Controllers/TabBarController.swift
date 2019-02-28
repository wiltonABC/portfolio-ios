//
//  TabBarController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 05/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var profile : Profile?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let mainController = self.parent as? MainViewController {
            mainController.sectionTitle.text = item.title
        }
    }
    
    func updateProfile(_ profile:Profile) {
        self.profile = profile
        //Sets about tab data on tab bar initial load
        if self.selectedIndex == 0 {
            let aboutTab = self.selectedViewController as? AboutViewController
            aboutTab?.aboutMeText.text = profile.about
        }
    }
    
}
