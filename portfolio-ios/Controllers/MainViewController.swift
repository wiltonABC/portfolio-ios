//
//  ViewController.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 03/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var sectionTitle: UILabel!
    @IBOutlet var shortName: UILabel!
    @IBOutlet var mainActivity: UILabel!
    var childTabBarController : TabBarController?
    var profile : Profile?
    var alertError : UIAlertController?
    var loadingView : UIView?

    override func viewDidAppear(_ animated: Bool) {
        showLoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabBar" {
            self.childTabBarController = segue.destination as? TabBarController
        }
    }

    private func showLoadingView() {
        //full screen loading view
        self.loadingView = UIView(frame:self.view.frame)
        loadingView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let loadAnimation = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        loadAnimation.style = UIActivityIndicatorView.Style.gray
        loadAnimation.hidesWhenStopped = true
        loadAnimation.center = self.loadingView?.center ?? CGPoint(x:0, y:0)
        loadAnimation.startAnimating()
        
        self.loadingView?.addSubview(loadAnimation)
        self.view.addSubview(loadingView!)
    }
    
    private func hideLoadingView() {
        self.loadingView?.removeFromSuperview()
    }
    
    private func showProfileError() {
        self.alertError = UIAlertController(title: "Communication Error", message: "Error getting profile data! Please, check your internet connection!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Try Again", style: .default) { (action) in
            self.alertError?.dismiss(animated: true, completion: nil)
            self.loadProfile()
        }
        
        self.alertError?.addAction(okButton)
        present(alertError!, animated: true, completion: nil)
    
    }
    
    private func loadProfile() {
        ProfileApiClient().getProfileById(1, success: { (profile) in
            self.profile = profile
            
            //Load Profile image from remote URL
            let baseUrl = Bundle.main.infoDictionary?["WEBAPI_ROOT_URL"] as! String
            Imageloader().getImageFromUrl(baseUrl + "/" + profile.image, success: { (imageData) in
                DispatchQueue.main.async {
                    self.profileImage.image = UIImage(data : imageData)
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
                }
            }, fail: { (error) in
                print(error.localizedDescription)
            })
            
            DispatchQueue.main.async {
                self.hideLoadingView()
                self.shortName.text = profile.shortName
                self.mainActivity.text = profile.mainActivity
                if let tabController = self.childTabBarController {
                    tabController.updateProfile(profile)
                }
            }
            
        }) { (error) in
            DispatchQueue.main.async {
                self.showProfileError()
            }
        }
    }
    
}

