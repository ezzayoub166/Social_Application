//
//  DeatilasUserVC.swift
//  Social_App
//
//  Created by ezz on 08/07/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class DeatilasUserVC: UIViewController {
    
    var owner : User!
    
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneNumberLAbel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var LoaderActivity: NVActivityIndicatorView!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdata()
    }
    
    func setUpUI(){
        ProfileImageView.setImage(imageUrl: owner.picture ?? "Not Found")
        NameLabel.text = owner.firstName + " " + owner.lastName
        EmailLabel.text = owner.email
        PhoneNumberLAbel.text = owner.phone
        CountryLabel.text = owner.location?.country
        GenderLabel.text = owner.gender
    }

}
extension DeatilasUserVC {
    func fetchdata(){
        LoaderActivity.startAnimating()
        UserAPI.getUser(completionHandler: { userResponse in
            self.owner = userResponse
            self.setUpUI()
            self.LoaderActivity.stopAnimating()
        }, route: .fetchUserInfo(owner.id))
        
//        let url    = "https://dummyapi.io/data/v1/user/\(owner.id)"
//            let headers : HTTPHeaders = [
//                "app-id":"62c01e88e0d5251ff41e1472"
//        ]
//        LoaderActivity.startAnimating()
//        AF.request(url, headers: headers).responseJSON { response in
//            let jsonData = JSON(response.value)
////            let data = jsonData["data"]
//            // مش راح يكون فيه وسيط بيني وبين الداتا راح اعتمد مباشرة على الداتا يلي بتجيني من الربسبونس
//            let decoder = JSONDecoder()
//            do {
//
//                self.owner = try decoder.decode(User.self, from: jsonData.rawData()) //convert the array of objects tybe jason ..to array of objects from Post Tybe
//                self.setUpUI()
//                self.LoaderActivity.stopAnimating()
//
//            }
//            catch let error {
//                print(error)
//            }
//        }
        
        
    }
}
