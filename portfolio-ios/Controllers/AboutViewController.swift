//
//  AboutViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 03/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutMeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: Notification.Name.init(rawValue: "profile"), object: nil)
    }
    
//    @objc func onDidReceiveData(_ notification:Notification) {
//        if let data = notification.userInfo as? [String:Profile] {
//            if let profile = data["profile"] {
//                self.profile = profile
//                DispatchQueue.main.async {
//                    self.aboutMeText.text = profile.about
//                }
//            }
//        }
//    }
    

}
