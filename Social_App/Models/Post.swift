//
//  Post.swift
//  Social_App
//
//  Created by ezz on 02/07/2022.
//

import Foundation
import UIKit
struct Post : Decodable {
    var id : String
    var image :String
    var likes : Int
    var text : String
    var owner : User
    var tags : [String]?
}
