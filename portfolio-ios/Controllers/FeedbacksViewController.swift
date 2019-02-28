//
//  FeedbacksViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 18/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class FeedbacksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var feedbackAuthor: UITextField!
    @IBOutlet var feedbackCompany: UITextField!
    @IBOutlet var feedbackMessage: MessageTextView!
    
    @IBOutlet var formScroll: UIScrollView!
    
    var feedbacksListView : FeedbacksListView?
    var feedbacks : [Feedback]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.feedbacksListView = UINib(nibName: "FeedbacksListView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? FeedbacksListView
        
        if let listView = feedbacksListView {
            self.view.addSubview(listView)
            
            listView.feedbacksTableView.delegate = self
            listView.feedbacksTableView.dataSource = self
            listView.feedbacksTableView.estimatedRowHeight = 500
            listView.feedbacksTableView.rowHeight = UITableView.automaticDimension
            listView.imageShowFeedbacks.isUserInteractionEnabled = true
            listView.imageShowFeedbacks.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toogleFeedbacks)))
            
            listView.frame.size.width = self.view.frame.width
            listView.frame.size.height = self.view.frame.height
            
            moveListToRight(x : self.view.frame.width - 30)
            
            //Update feedbacks UITableView
            
            if let profile = (self.parent as! TabBarController).profile {
                FeedbacksApiClient().getFeedbacksByProfileId(profile.idProfile, success: { (feedbacks) in
                    self.feedbacks = feedbacks
                    DispatchQueue.main.async {
                        listView.feedbacksTableView.reloadData()
                    }
                        
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(prepareViewForKeyboard(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustViewWithoutKeyboard(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)

    }
    
    @IBAction func sendFeedback(_ sender: Any) {
        if !formIsValid() {
            return
        }
        
        if let profile = (self.parent as! TabBarController).profile {
            let feedback = getFormData(profile: profile)
            FeedbacksApiClient().sendFeedback(feedback: feedback, success: { (statusCode) in
                if statusCode == 201 {
                    DispatchQueue.main.async {
                        self.clearForm()
                        DismissableAlertController(title: "", message: "Feedback successfully sent!", preferredStyle: .alert).showAndDismissAfter(presentingController: self, time: 1.5)
                    }
                } else {
                    DispatchQueue.main.async {
                        DismissableAlertController(title: "", message: "Your feedback could not be delivered!", preferredStyle: .alert).showAndDismissAfter(presentingController: self, time: 1.5)
                    }
                }
            }) { (error) in
                DispatchQueue.main.async {
                    DismissableAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert).showAndDismissAfter(presentingController: self, time: 1.5)
                }
            }
        }
    }
    
    
    func getFormData(profile : Profile) -> Feedback {
        let currentDateUnix = Date(timeIntervalSince1970: floor(Date().timeIntervalSince1970))
        let feedback = Feedback(idFeedback: 0, profile: profile, author: feedbackAuthor.text!, company: feedbackCompany.text!, text: feedbackMessage.text!, dateCreated: currentDateUnix)
        return feedback
    }
    
    func formIsValid() -> Bool {
        var message = ""
        var isValid = true
        
        let authorLength = feedbackAuthor.text?.count ?? 0
        let companyLength = feedbackCompany.text?.count ?? 0
        let messageLength = feedbackMessage.text?.count ?? 0
        
        if authorLength == 0 {
            message += "Fill the author!\n"
            isValid = false
        } else {
            if authorLength > 30 {
                message += "The author must have up to 30 characters!\n"
                isValid = false
            }
        }
        
        if companyLength == 0 {
            message += "Fill the company!\n"
            isValid = false
        } else {
            if companyLength > 30 {
                message += "The company field must have up to 30 characters!\n"
                isValid = false
            }
        }
        
        if messageLength == 0 {
            message += "Fill the message!\n"
            isValid = false
        } else {
            if messageLength > 60 {
                message += "The feedback message must have up to 60 characters!\n"
                isValid = false
            }
        }
        
        if message != ""{
            let alert = ValidationAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
        }
        
        return isValid
        
    }
    
    func moveListToRight(x : CGFloat) {
        self.feedbacksListView?.transform = CGAffineTransform.identity.translatedBy(x: x, y: 0)
    }
    
    func moveListToLeft() {
        self.feedbacksListView?.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
    }
    
    @objc func toogleFeedbacks(gestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            if self.feedbacksListView?.frame.origin.x == 0 {
                self.moveListToRight(x : self.view.frame.width - 30)
            } else {
                self.moveListToLeft()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "feedback-cell") as? FeedbackCellView
        
        if cell == nil {
            
            cell = UINib(nibName: "FeedbackCellView", bundle: nil).instantiate(withOwner: tableView, options: nil)[0] as? FeedbackCellView
            
        }
        
        guard let text = feedbacks?[indexPath.row].text else {return cell!}
        guard let author = feedbacks?[indexPath.row].author else {return cell!}
        guard let company = feedbacks?[indexPath.row].company else {return cell!}
        
        cell?.feedbackText.text = text
        cell?.feedbackAuthor.text = "\(author) - \(company)"
        return cell!
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        moveListToRight(x: size.width - 30)
        
        if UIDevice.current.orientation.isPortrait {
            restoreView()
        }
    }
    
    func clearForm() {
        self.feedbackAuthor.text = ""
        self.feedbackCompany.text = ""
        self.feedbackMessage.text = ""
    }
    
    @objc func resizeScrollViewForKeyboard(notification : Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.formScroll.contentSize = CGSize(width: self.formScroll.frame.width, height: self.formScroll.frame.height + keyboardFrame.cgRectValue.height)
        }
        
    }
    
    @objc func prepareViewForKeyboard(notification : Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.formScroll.contentSize = CGSize(width: self.formScroll.frame.width, height: self.formScroll.frame.height + keyboardFrame.cgRectValue.height)
        }
        
        if UIDevice.current.orientation.isLandscape {
            if let mainController = self.parent?.parent as? MainViewController {
                mainController.mainHeaderView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -mainController.mainHeaderView.frame.height)
                
                mainController.tabBarContainer.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -mainController.mainHeaderView.frame.height)
                
            }
        }
    }
    
    @objc func adjustViewWithoutKeyboard(notification : Notification) {
        if UIDevice.current.orientation.isLandscape {
            restoreView()
        }
    }
    
    func restoreView() {
        if let mainController = self.parent?.parent as? MainViewController {
            mainController.mainHeaderView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
            
            mainController.tabBarContainer.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
        }
    }
    
}
