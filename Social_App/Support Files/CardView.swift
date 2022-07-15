//
//  CardView.swift
//  Social_App
//
//  Created by ezz on 03/07/2022.
//

import Foundation
import UIKit
class CardView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialsetup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialsetup()
        
    }
    
    private func initialsetup(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1

    }
}
