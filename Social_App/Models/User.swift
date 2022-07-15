//
//  User.swift
//  Social_App
//
//  Created by ezz on 03/07/2022.
//

import Foundation
struct User : Decodable {
    var id : String
    var firstName : String
    var lastName : String
    var picture : String?
    var gender  : String?
    var phone : String?
    var email : String?
    var location : location?
}

struct UserModel : Codable {
    var id : String?
    var firstName : String?
    var lastName : String?
}
