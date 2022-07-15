//
//  UserAPI.swift
//  Social_App
//
//  Created by ezz on 09/07/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserAPI : API {

    static func getUser(completionHandler : @escaping (User) -> () , route : Route){  // completionHandler هي عبارة عن بارميتر يمثل دالة يتم تنفيذها واستدعائها من داخل الدالة ...
        let url = Route.BaseURL + route.descreption
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                // posts fill the response come by Request ....
                // posts is about the array
                let user = try decoder.decode(User.self, from: jsonData.rawData()) //convert the array of objects tybe jason ..to array of objects from Post Tybe
                completionHandler(user) //
            }
            catch let error {
                print(error)
            }
        }
    }
    // optional mean maybe we have the user or we dont have user
    static func creatNewUser(firstName : String , lastName : String , email : String ,completionHandler : @escaping (User? , String?) -> ()  , route : Route ){
        var parms  = [
            "firstName" : firstName,
            "lastName" : lastName ,
            "email" : email
        ]
        let url = Route.BaseURL + route.descreption
        AF.request(url, method: .post, parameters: parms, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case . success:
                let jsonData = JSON(response.value)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user , nil)
                }
                catch let error {
                    print(error)
                }
            case .failure(let error):
                // لو كان عنا رسالة خطأ جوا الريسبونس مثلا زي انه الايميل موجود
                // وبدي اصل لهذه الرسالة
                // response.data conve
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                // Error Messages
                let emailError = data["email"].stringValue
                let FirstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let ErrorMessage = emailError + " " + FirstNameError + " " + lastNameError
                completionHandler(nil, ErrorMessage)
            }
        }
        
    }

    static func SingInUser(firstName : String , lastName : String ,completionHandler : @escaping (User? , String?) -> ()){
        
        //MARK: this parametres from Tybe Query Parmaters so must Change the JSONParameterEncoder.default
        //MARK: to URLEncodedFormParameterEncoder.default mean add to url ?1
        
        var parms  = [
            "created" : "1"
        ]
        
        let url = "https://dummyapi.io/data/v1/user"
        AF.request(url, method: .get, parameters: parms, encoder: URLEncodedFormParameterEncoder.default , headers: headers).validate().responseJSON { response in
            switch response.result {
            case . success:
                let jsonData = JSON(response.value)
                let data = jsonData["data"]
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data.rawData())
                    var userFound : User? // Value Maybe Change so var not let
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            userFound = user
                            break
                        }
                    }
                    if let user = userFound {  // mean is userFound not Nill
                    completionHandler(user, nil)
                    }
                    else {
                        completionHandler(nil , "the First Name or last Name dose't match Any user")
                    }
                    
//                    completionHandler([user] , nil)
                }
                catch let error {
                    print(error)
                }
            case .failure(let error):
                // لو كان عنا رسالة خطأ جوا الريسبونس مثلا زي انه الايميل موجود
                // وبدي اصل لهذه الرسالة
                // response.data conve
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                // Error Messages
                let emailError = data["email"].stringValue
                let FirstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let ErrorMessage = emailError + " " + FirstNameError + " " + lastNameError
                completionHandler(nil, ErrorMessage)
            }
        }
        
    }
}
