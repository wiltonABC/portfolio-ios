//
//  WorkViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 14/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class WorkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var worksTableView: UITableView!
    var works : [WorkDone]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        worksTableView.delegate = self
        worksTableView.dataSource = self
        worksTableView.estimatedRowHeight = 500
        worksTableView.rowHeight = UITableView.automaticDimension
        
        loadWorks()
    }
    
    func loadWorks() {
        let profile = (self.parent as? TabBarController)?.profile
        WorksApiClient().getWorksByProfileId(profile!.idProfile, success: { (works) in
            self.works = works
            DispatchQueue.main.async {
                self.worksTableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = works?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "work-cell") as! WorkTableViewCell
        
        if let work = works?[indexPath.row] {
            cell.setWorkData(work: work)
        }
        
        return cell
    }
    

}
