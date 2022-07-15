//
//  SingInVC.swift
//  Social_App
//
//  Created by ezz on 11/07/2022.
//

import UIKit
import Spring

class SingInVC: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var SingInLabel: SpringLabel!
    @IBOutlet weak var FirstNametxt: SpringTextField!
    @IBOutlet weak var LastNametxt: SpringTextField!
    @IBOutlet weak var SkipButton: UIButton!
    @IBOutlet weak var SingInButton: SpringButton!
    @IBOutlet weak var SkinpButton: SpringButton!
    @IBOutlet weak var RegisterButton: SpringButton!
    
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        setUpView()
        
    
     
    }

    // MARK: Actions
    @IBAction func SingInButtonClicked(_ sender: Any) {
        fetchdata()
        
    }
    @IBAction func SkipButton(_ sender: Any) {
        let contoller = MainTabBarController.instantiate()
        self.navigationController?.pushViewController(contoller, animated: true)
         
        
//        let vc = UIStoryboard.mainStoryborad.instantiateViewController(withIdentifier: "HomeVC")
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func CreateNewUserButton(_ sender: Any) {
        let controller = CreatNewUserVC.instantiate()
        controller.modalTransitionStyle = .flipHorizontal
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension SingInVC {
    
    func setUpView(){
        
        //MARK: For Animations TextFileds....
        
        LastNametxt.animation = "squeezeDown"
           LastNametxt.delay = 0.5 // التأخير يلي راح يصير قبل الانيمشن
           LastNametxt.duration = 1
           LastNametxt.animate()
           
           FirstNametxt.animation = "squeezeDown"
           FirstNametxt.delay = 0.6 // التأخير يلي راح يصير قبل الانيمشن
           FirstNametxt.duration = 1
           FirstNametxt.animate()
           
         
           
           SingInButton.animation = "squeezeDown"
        SingInButton.delay = 0.9 // التأخير يلي راح يصير قبل الانيمشن
           SingInButton.duration = 1
           SingInButton.animate()
        
        
        SingInLabel.animation = "fadeInUp"
     SingInLabel.delay = 1 // التأخير يلي راح يصير قبل الانيمشن
        SingInLabel.duration = 2
        SingInLabel.animate()
        
        
        SkinpButton.animation = "squeezeUp"
        SkinpButton.delay = 1.4
        SkinpButton.duration = 1
        SkinpButton.animate()
        
        RegisterButton.animation = "squeezeLeft"
        RegisterButton.delay = 1.8
        RegisterButton.duration = 1
        RegisterButton.animate()
    }
    
    func AnimateOut(user : User?){
        LastNametxt.animation = "squeezeDown"
           LastNametxt.delay = 0.5 // التأخير يلي راح يصير قبل الانيمشن
           LastNametxt.duration = 1
           LastNametxt.animateTo()
           
           FirstNametxt.animation = "squeezeDown"
           FirstNametxt.delay = 0.6 // التأخير يلي راح يصير قبل الانيمشن
           FirstNametxt.duration = 1
           FirstNametxt.animateTo()
           
         
           
           SingInButton.animation = "squeezeDown"
        SingInButton.delay = 0.9 // التأخير يلي راح يصير قبل الانيمشن
           SingInButton.duration = 1
           SingInButton.animateTo()
        
        
        SingInLabel.animation = "fadeInUp"
     SingInLabel.delay = 1 // التأخير يلي راح يصير قبل الانيمشن
        SingInLabel.duration = 2
        SingInLabel.animateTo()
        
        
        SkinpButton.animation = "squeezeUp"
        SkinpButton.delay = 1.4
        SkinpButton.duration = 1
        SkinpButton.animateTo()
        
        RegisterButton.animation = "squeezeLeft"
        RegisterButton.delay = 1.8
        RegisterButton.duration = 1
        RegisterButton.animateToNext(completion: {
            
                if let userLogin = user {
                let contoller = MainTabBarController.instantiate()
                contoller.modalTransitionStyle = .flipHorizontal
                contoller.modalPresentationStyle = .fullScreen
                UserManager.loggedInUser = userLogin
                self.navigationController?.pushViewController(contoller, animated: true)
            }

        })
    }
    
    func fetchdata(){
        UserAPI.SingInUser(firstName: FirstNametxt.text!, lastName: LastNametxt.text!, completionHandler: { user, error in
            if let errorMessage = error {
                let Alter = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let AlterAction = Alter.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                self.present(Alter, animated: true)
                
            }
            else {
                self.AnimateOut(user: user)
            }
        })
    }
}
