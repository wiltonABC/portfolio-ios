//
//  DismissableAlertController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 23/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class DismissableAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showAndDismissAfter(presentingController : UIViewController, time : Double) {
        
        presentingController.present(self, animated: true, completion: nil)
        
        let timeOfExecution = DispatchTime.now() + time
        
        DispatchQueue.main.asyncAfter(deadline: timeOfExecution) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
