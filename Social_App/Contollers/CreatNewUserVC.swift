//
//  CreatNewUserVC.swift
//  Social_App
//
//  Created by ezz on 10/07/2022.
//

import UIKit

class CreatNewUserVC: UIViewController {

    @IBOutlet weak var firstNametxt: UITextField!
    @IBOutlet weak var lastNametxt: UITextField!
    @IBOutlet weak var Emailtxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        UserAPI.creatNewUser(firstName: firstNametxt.text!, lastName: lastNametxt.text!, email: Emailtxt.text!,completionHandler: { user , errorMessage in
            if errorMessage != nil {
                let Alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil )
                Alert.addAction(okAction)
                self.present(Alert, animated: true)
            }
            else if let Loggeduser = user{
                    let controller = MainTabBarController.instantiate()
                    controller.modalTransitionStyle = .flipHorizontal
                    controller.modalPresentationStyle = .fullScreen
                UserManager.loggedInUser = Loggeduser
                self.navigationController?.pushViewController(controller, animated: true)
                
                    }
                   
        
        }, route: .fetchCreatNewUser)
    }
    
    
    @IBAction func SingInButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
 
