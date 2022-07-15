//
//  UpdateUserData.swift
//  Social_App
//
//  Created by ezz on 19/07/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class UpdateUserDataVC: UIViewController {
    @IBOutlet weak var NewFirstName: UITextField!
    @IBOutlet weak var NewPhonetxt: UITextField!
    @IBOutlet weak var NewImageText: UITextField!
    @IBOutlet weak var ImageUser: UIImageView!
    @IBOutlet weak var FullNamelbl: UILabel!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpView()
         

        // Do any additional setup after loading the view.
    }
    @IBAction func SubmitButton(_ sender: Any) {
        if let user = UserManager.loggedInUser {
            
            fetchdata()
            let Alter = UIAlertController(title: "Sucess", message: "done Update", preferredStyle: .alert)
            let AlterAction = Alter.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            self.present(Alter, animated: true)
            NewFirstName.text = ""
            NewPhonetxt.text = ""
            NewImageText.text = ""
            self.showAlterPop(massage: "Sucess data", titel: "sucess") {
                let vc = MainTabBarController.instantiate()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            
            let Alter = UIAlertController.init(title: "Wrong!!", message: "Must Sing in", preferredStyle: .actionSheet)
            let ActionAlter = UIAlertAction.init(title: "Ok", style: .default)
            Alter.addAction(ActionAlter)
            self.present(Alter, animated: true)
        }
    }
    
}

extension UpdateUserDataVC  {
    func setUpView(){
        if let user = UserManager.loggedInUser {
            if let image = user.picture {
                ImageUser.setImage(imageUrl: image)
            }
            NewFirstName.text = user.firstName
            NewImageText.text = user.picture
            NewPhonetxt.text = user.phone
            FullNamelbl.text = "hi , \(user.firstName) \(user.lastName)"
            
        }
        else{
            FullNamelbl.text = ""
        }
        
    
        
    }
    
    func fetchdata(){
        let parms = [
            "firstName" : NewFirstName.text! ,
            "phone":NewPhonetxt.text!,
            "picture":NewImageText.text!
        ]
        guard let user = UserManager.loggedInUser else {return}
        let url = "\(Route.BaseURL)/user/\(user.id)"
        loaderView.startAnimating()
        AF.request(url, method: .put, parameters: parms, encoder: JSONParameterEncoder.default, headers: API.headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                self.loaderView.stopAnimating()
                let jsonData = JSON(response.data)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    if let picture = user.picture {
                        self.ImageUser.setImage(imageUrl: picture)
                    }
                    self.FullNamelbl.text = "\(user.firstName) \(user.lastName)"
                }
                catch let error {
                    print("Some Error In decodeing")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension UpdateUserDataVC {

        func showAlterPop(Title : String , Message : String  ){
            let Alter = UIAlertController.init(title: Title, message: Message, preferredStyle: .alert)
            self.present(Alter, animated: true, completion: nil)
        }
        func showAlterPop(massage : String , titel : String , ButtonOkayTitel : String = "Okay", buttonStyle1 : UIAlertAction.Style = .default , Action1 ButtonTitelAction : @escaping ()-> Void) {
            
            let alter = UIAlertController.init(title: titel, message: massage, preferredStyle: .alert)
            let button1 = UIAlertAction.init(title: ButtonOkayTitel,style:  buttonStyle1) {
              (action) in
                print("Button Okay")
                ButtonTitelAction()
                
            }
            alter.addAction(button1)
            self.present(alter, animated: true, completion: nil)
            
            
            
        }
    }
