//
//  SkillsViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 03/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var skillsTableView: UITableView!
    var skillCategories : [SkillCategory]?

    let headerId = "tableview-section-header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        skillsTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        loadSkills()
    }
    
    func loadSkills() {
        let profile = (self.parent as? TabBarController)?.profile
        SkillsApiClient().getSkillsByProfileId(profile!.idProfile, success: { (skills) in
            let handler = SkillsDataHandler()
            let skillsList = handler.getSkillsByCategory(skills: skills)
            self.skillCategories = skillsList
            DispatchQueue.main.async {
                self.skillsTableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categories = skillCategories {
            if let skillsCount = categories[section].skills?.count {
                return skillsCount
            }
        }
        return 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let categoriesCount = skillCategories?.count else { return 0 }
        return categoriesCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.headerId)
        
        var headerView = SkillTableViewSection()
        if header?.contentView.subviews.count == 0 {
            headerView = UINib(nibName: "SkillCategoryTableViewHeaderFooterView", bundle: nil).instantiate(withOwner: headerView, options: nil)[0] as! SkillTableViewSection
        
            
            header?.contentView.addSubview(headerView)
        } else {
            headerView = header?.contentView.subviews[0] as! SkillTableViewSection
        }
        
        if let category = skillCategories?[section] {
            headerView.setSkillCategorySectionData(category: category)
        }
        
        headerView.frame.size.height = 83.5
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skill-cell") as! SkillTableViewCell
        if let categories = skillCategories {
            if let skill = categories[indexPath.section].skills?[indexPath.row] {
                cell.setSkillData(skill: skill)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 83.5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.subviews[0].backgroundColor = UIColor(red: 86/255, green: 61/255, blue: 124/255, alpha: 1.0)
    }
}
