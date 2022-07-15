//
//  PostCellTableViewCell.swift
//  Social_App
//
//  Created by ezz on 02/07/2022.
//

import UIKit
import Kingfisher
import Foundation

class PostCellTableViewCell: UITableViewCell  {
    
    var tags :[String] = []
    let  imageUserNotFound = "https://cdn.icon-icons.com/icons2/3106/PNG/512/person_avatar_account_user_icon_191606.png"
    
    @IBOutlet weak var UserStackView: UIStackView!{
        didSet{
            UserStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStakeViewTapped)))
        }
    }
    
    @IBOutlet weak var NotFoundPictureView: UIView!
    @IBOutlet weak var TextPostLabel: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var LikesNumberLabel: UILabel!
    @IBOutlet weak var TagsCollectionView: UICollectionView! {
        didSet{
            TagsCollectionView.dataSource = self
            TagsCollectionView.delegate = self
        }
    }
    @IBOutlet weak var DeletePost: UIView!{
        didSet{
            DeletePost.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deletePost)))
        }
    }
    
    
    
    
    
    func setUp(postObject : Post){
        TextPostLabel.text = postObject.text
        UserNameLabel.text = postObject.owner.firstName + " " + postObject.owner.lastName
        UserImage.setImage(imageUrl: postObject.owner.picture ?? imageUserNotFound)
        LikesNumberLabel.text = String(postObject.likes)
        if let user = UserManager.loggedInUser {
            if user.id != postObject.owner.id {
                DeletePost.isHidden = true
            }
            else {
            DeletePost.isHidden = false
            }
        }
        else{
            DeletePost.isHidden = true
        }
        
        if postObject.tags?.isEmpty == true{
            TagsCollectionView.isHidden = true
        }
}
    
    // MARK: Actions
    @objc func userStakeViewTapped(){
        
        NotificationCenter.default.post(name: NSNotification.Name("userStakeViewTapped"), object: nil, userInfo: ["cell" : self])
        // هنا سيتم ارسال الاوبجكت نفسه  
        
        
    }
    @objc func deletePost(){
        NotificationCenter.default.post(name: NSNotification.Name("deletePost"), object: nil, userInfo: ["Cell" : self])
        
    }
}

extension PostCellTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TagsCollectionView.dequeueReusableCell(withReuseIdentifier: "PostTagsCell", for: indexPath) as! PostTagsCell
        cell.NameTextTag.text = tags[indexPath.row]
        return cell
    }
}
