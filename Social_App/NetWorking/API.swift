//
//  API.swift
//  Social_App
//
//  Created by ezz on 10/07/2022.
//

import Foundation
import Alamofire
class API {
    static let shared = API()
    static let appID = "62d89a8d0227827564a8746f"
    static let headers : HTTPHeaders = [
        "app-id": appID
]
     
}
