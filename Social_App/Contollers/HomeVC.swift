		//
//  ViewController.swift
//  Social_App
//
//  Created by ezz on 02/07/2022.
//

import UIKit
import NVActivityIndicatorView
import SwiftyJSON
import Alamofire

class HomeVC: UIViewController {
    
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var tableViewPosts: UITableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var TagNameLabel: UILabel!
    @IBOutlet weak var ViewTag: UIView!
    @IBOutlet weak var CloseBtn: UIButton!
    @IBOutlet weak var CreateNewPost: UIView!

    
    
    var posts : [Post] = []
    var loggedInUser : User?
    var tag : String?
    var page = 0
    var total = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // check if user is logged in or it's only Guest
     
        setupview()
        fetchdata()
        setUpdta()
        loclized()
        // completionHandler الدالة التي سوف يتم استدعائها وقت الحصوةل على الريسبونس بطريقة مناسبة..
        PostAPI.getAllPosts(page: 0, completionHandler: {  post, total in
            self.total = total
            self.posts = post
            self.tableViewPosts.reloadData()
        }, route: .fetchAllPosts)
    }



    
    //MARK: Actions ....
    
    @IBAction func ButtonSingIn(_ sender: Any) {
        let vc = SingInVC.instantiate()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        UserManager.loggedInUser = nil
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ButtonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func AddPostButton(_ sender: Any) {
        let controller = NewPostVC.instantiate()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}

extension HomeVC {
    func setupview(){
        tableViewPosts.dataSource = self
        tableViewPosts.delegate = self
        
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTabpped) , name: NSNotification.Name("userStakeViewTapped"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdd) , name: NSNotification.Name("NewPostAdd"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deletePost), name: NSNotification.Name("deletePost"), object: nil)
        
        // MARK: Welcome message to the user on the main screen who is logged in
        if let user = UserManager.loggedInUser {
            hiLabel.text = "Hi , \(user.firstName)"
    
        }
        else{
            hiLabel.isHidden = true
            CreateNewPost.isHidden = true
            
        }
        // MARK: For Tags...
        if let mytag = tag {
            TagNameLabel.text = mytag
        }
        else
            {
            ViewTag.isHidden = true
            }
        
    }
    func setUpdta(){
        
    }
    func fetchdata(){
        loaderView.startAnimating()
        if tag == nil {
            PostAPI.getAllPosts(page: page , completionHandler: { postsResponse,total  in
            self.total = total
            self.posts.append(contentsOf: postsResponse)
            self.tableViewPosts.reloadData()
            self.loaderView.stopAnimating()
        }, route: .fetchAllPosts)
        }
        else {
            PostAPI.getAllPostsByTag(completionHandler: { posts in
                self.posts = posts
                self.tableViewPosts.reloadData()
                self.loaderView.stopAnimating()
            }, route: .fetchPostsByTag(tag!))
        }
        
    }
    func getAllposts(){
        loaderView.startAnimating()
        PostAPI.getAllPosts(page: page, completionHandler: { post, total in
            self.total = total
            self.posts.append(contentsOf: post)
            self.tableViewPosts.reloadData()
            self.loaderView.stopAnimating()
        }, route: .fetchAllPosts)
    }
    func loclized(){
        
    }
    
    //MARK: ACTIONS
    @objc func userProfileTabpped(notification:Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
          if  let indexPath = tableViewPosts.indexPath(for: cell) // get the index for the selectted the cell
            {
             let post = posts[indexPath.row]
              //MARK: create the user Datiles
              let contoller = storyboard?.instantiateViewController(withIdentifier: "DeatilasUserVC") as! DeatilasUserVC
              contoller.owner = post.owner
              present(contoller, animated: true)
          }
        }

    }
    
    @objc func deletePost(notification : Notification) {
        if let user = UserManager.loggedInUser {
        if let cell = notification.userInfo?["Cell"] as? UITableViewCell{
            if let indexPath = tableViewPosts.indexPath(for: cell)
            {
                let post = posts[indexPath.row]
                if user.id == post.owner.id {
                    self.showAlterPop(massage: "Are you sure to delete the post?", titel: "sure") {
                        let url = "\(Route.BaseURL)/post/\(post.id)"
                        AF.request(url, method: .delete , headers: API.headers).validate().responseData { response in
                            switch response.result {
                            case .success:
                              print("Done Delete")
                                self.posts.remove(at: indexPath.row)
                                self.tableViewPosts.deleteRows(at: [indexPath], with: .automatic)
                                self.tableViewPosts.reloadData()
                                
                            case .failure(let error):
                                print(error)
                            
                            }
                            }
                    }
             
            }
                }
            }
            }
        }
    // سيتم استدعاء هده الدالة عند اضافة بوست جديدددد
    @objc func newPostAdd(){
        self.posts = []
        self.page = 0
         fetchdata()
        
    }
}

extension HomeVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPosts.dequeueReusableCell(withIdentifier: " PostCell", for: indexPath) as! PostCellTableViewCell
        cell.selectionStyle = .none
        // for Array of tags....
        let post = posts[indexPath.row]
        cell.tags = post.tags ?? []
        cell.setUp(postObject: posts[indexPath.row])
        cell.imagePost.setImage(imageUrl: post.image)
        if cell.imagePost.image == nil {
            cell.NotFoundPictureView.isHidden = false
        }
        else{
            cell.NotFoundPictureView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 605
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row]
        let contoller = storyboard?.instantiateViewController(withIdentifier: "DatilesPostVC") as! DatilesPostVC
        contoller.post = selectedPost
        present(contoller, animated: true , completion: nil)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 1 && posts.count < total {
            page+=1
           fetchdata()
        } 
    }
}
extension HomeVC {

        func showAlterPop(Title : String , Message : String  ){
            let Alter = UIAlertController.init(title: Title, message: Message, preferredStyle: .alert)
            self.present(Alter, animated: true, completion: nil)
        }
        func showAlterPop(massage : String , titel : String , ButtonOkayTitel : String = "Okay", buttonStyle1 : UIAlertAction.Style = .default , Action1 ButtonTitelAction : @escaping ()-> Void) {
            
            let alter = UIAlertController.init(title: titel, message: massage, preferredStyle: .alert)
            let button1 = UIAlertAction.init(title: ButtonOkayTitel,style:  buttonStyle1) {
              (action) in
                print("Button Okay")
                ButtonTitelAction()
                
            }
            alter.addAction(button1)
            self.present(alter, animated: true, completion: nil)
            
            
            
        }
    }
