//
//  Extenstions.swift
//  Social_App
//
//  Created by ezz on 03/07/2022.
//

import Foundation
import UIKit
import Alamofire
extension String {
    var asURl : URL? {
        return URL(string: self )
    }
}
extension UIImageView {
    func setImage(imageUrl : String ){
        self.kf.setImage(with : URL(string : imageUrl))
    }
    
    func setImageFromStringUrl(stringUrl : String){
        if let url = URL(string: stringUrl) {
//            if let imageData = try? Data(contentsOf: url){
                self.kf.setImage(with: url)
            }
        }

    @IBInspectable var isRounded : Bool {
        set {
            self.layer.cornerRadius = self.frame.height / 2
            
        }
        get {
            return self.layer.cornerRadius == self.frame.height / 2
        }
    }
    
}
extension UIViewController {
    
    
    
    static var identifier : String {
        return String(describing:  self )
    }
    
    static func instantiate() -> Self {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        return storybord.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
