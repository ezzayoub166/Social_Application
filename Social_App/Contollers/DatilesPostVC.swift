//
//  DatilesPostVC.swift
//  Social_App
//
//  Created by ezz on 05/07/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class DatilesPostVC: UIViewController  {
    
    var post : Post!   //  يتم تعبئة هذا المتغير على حسب المكان الذي ضغط عليه هذا المستخدم  من الهوم في سي اي من الشاشة الرئيسية

    var comments : [Comment] = []
    
    let appID = "62d1bf10cbe573fe170caeef"
    
    let url = "https://dummyapi.io/data/v1/comment/create"
    
// MARK: OULETES
    
    @IBOutlet weak var UserPictureImage: UIImageView!
    @IBOutlet weak var UserNameLabeal: UILabel!
    @IBOutlet weak var TextPostLabel: UILabel!
    @IBOutlet weak var PicturePostImage: UIImageView!
    @IBOutlet weak var NumberOfLikesLabel: UILabel!
    @IBOutlet weak var ExitButton: UIButton!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var Commenttxt: UITextField!
    @IBOutlet weak var SendCommentbtn: UIButton!
    @IBOutlet weak var NewComment: UIStackView!
    @IBOutlet weak var NoCommentLabel: UIView!
    
    
    
    
    
// MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManager.loggedInUser == nil {
            NewComment.isHidden = true
        }
        setUpview()
        fetchdata()
        localized()
   
}
    
    @IBAction func SendCommentButton(_ sender: Any) {
     
        if let user = UserManager.loggedInUser {
            let parms = [
                "message": Commenttxt.text!,
                "owner": user.id,
                "post": post.id
            ] as [String : Any]
//            CommentAPI.createComment(comment: Commenttxt.text!, PostID: post.id, UserID: user.id) {
//                self.fetchdata()
//                self.Commenttxt.text = ""
            AF.request(url, method: .post, parameters: parms, headers: API.headers).responseJSON { response in
                self.fetchdata()
                self.Commenttxt.text = ""
            }
            }
        else{
            let Alter = UIAlertController(title: "Some Wrong", message: "Plase Sing In ", preferredStyle: .actionSheet)
            let AlterAction = UIAlertAction(title: "Ok", style: .default)
            Alter.addAction(AlterAction)
            self.present(Alter, animated: true)
        }
    }
    
    @IBAction func ExitButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
extension DatilesPostVC {
    func setUpview(){
        ExitButton.layer.cornerRadius = ExitButton.frame.width / 2
        CommentsTableView.dataSource = self
        CommentsTableView.delegate = self
        checkComments()
        
   
        
        
    }
    func fetchdata(){
       
        // MARK: Getting the Comments of the Post From the api
//        let url = "https://dummyapi.io/data/v1/post/\(post.id)/comment"
        getDataFromMain(postWanted: post) // get all data of the selected post 
//        loaderView.startAnimating()
        PostAPI.getCommentsOfPosts(completionHandler : { commentsResponse in
            self.comments = commentsResponse
            self.CommentsTableView.reloadData()
            self.checkComments()
//            self.loaderView.stopAnimating()
        }, route: .fetchComments(post.id))
        
    }
    func localized()
    {
        
    }
}
extension DatilesPostVC {
    func getDataFromMain(postWanted : Post){
        UserPictureImage.setImage(imageUrl: postWanted.owner.picture ?? "https://cdn.icon-icons.com/icons2/3106/PNG/512/person_avatar_account_user_icon_191606.png")
        UserNameLabeal.text = postWanted.owner.firstName + " " + postWanted.owner.lastName
        TextPostLabel.text = postWanted.text
        PicturePostImage.setImageFromStringUrl(stringUrl: postWanted.image)
        NumberOfLikesLabel.text = String(postWanted.likes)
    }
    
    func checkComments(){
        if CommentsTableView.visibleCells.isEmpty {
            NoCommentLabel.isHidden = false
            print("is Empty")
        }
        else{
            NoCommentLabel.isHidden = true
        }
    }
}

extension DatilesPostVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommentsTableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        cell.setup(comment: comments[indexPath.row])
        return cell
    }
}
