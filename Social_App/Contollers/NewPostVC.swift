//
//  NewPostVC.swift
//  Social_App
//
//  Created by ezz on 16/07/2022.
//

import UIKit
import NVActivityIndicatorView

class NewPostVC: UIViewController {

    @IBOutlet weak var TextNewPost: UITextView!
    
    
    @IBOutlet weak var UrlPictureNewPost: UITextField!
    
    @IBOutlet weak var LoaderView: NVActivityIndicatorView!
    
    @IBOutlet weak var AddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
    }

    @IBAction func BackHomeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func AddNewPost(_ sender: Any) {
        if let user = UserManager.loggedInUser{
            AddButton.setTitle("", for: .normal)
            LoaderView.startAnimating()
            
            PostAPI.AddNewPost(message: TextNewPost.text!, UserID: user.id, picture:UrlPictureNewPost.text! , completionHandler: {
                self.LoaderView.stopAnimating()
                self.AddButton.setTitle("Add!", for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdd"), object: nil)
                self.dismiss(animated: true )
            }, route: .fetchcreateNewPost)
        }
        TextNewPost.text = ""
        UrlPictureNewPost.text = ""
      
        
    }
}
