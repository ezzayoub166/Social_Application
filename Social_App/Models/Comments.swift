//
//  Comments.swift
//  Social_App
//
//  Created by ezz on 05/07/2022.
//

import Foundation
import UIKit
struct Comment : Decodable {
    var message : String
    var id : String
    var owner : User
    
}
