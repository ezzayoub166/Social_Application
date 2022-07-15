//
//  CommentsCell.swift
//  Social_App
//
//  Created by ezz on 05/07/2022.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var CommentTextCell: UILabel!
    
    @IBOutlet weak var CommentUserImage: UIImageView!
    
    @IBOutlet weak var CommentUserName: UILabel!
    
    let  imageUserNotFound = "https://cdn.icon-icons.com/icons2/3106/PNG/512/person_avatar_account_user_icon_191606.png"
    
    func setup(comment : Comment){
      
        CommentUserName.text = comment.owner.firstName + " " + comment.owner.lastName
        CommentTextCell.text = comment.message
        CommentUserImage.setImage(imageUrl: comment.owner.picture ?? imageUserNotFound)
    }
    
}
