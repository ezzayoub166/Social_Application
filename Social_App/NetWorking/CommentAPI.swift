//
//  CommentAPI.swift
//  Social_App
//
//  Created by ezz on 12/07/2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class CommentAPI : API {
    static func createComment(comment : String , PostID : String , UserID :String  , completionHandler : @escaping () -> () ) {
        var parms = [
            "message": comment,
               "owner": UserID,
               "post": PostID
        ]
        
        let url = "https://dummyapi.io/data/v1/comment/create"
        AF.request(url, method: .post, parameters: parms, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { commentResponse in
            switch commentResponse.result {
            case .success:
                let jsonData=JSON(commentResponse)
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
