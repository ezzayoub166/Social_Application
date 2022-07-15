//
//  TagsVC.swift
//  Social_App
//
//  Created by ezz on 13/07/2022.
//
import UIKit
import NVActivityIndicatorView
import Alamofire

class TagsVC: UIViewController {
    //MARK: Outlets.....
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    
    var tags : [String]  =  ["dog","nature","sea","tree","winter","London is the capital of Great Britten"]
    
    var selectedTag : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loclized()
        setUpdata()
        fetchdata()
//        loaderView.startAnimating()
//        PostAPI.getAllTags { tags in
//            self.loaderView.stopAnimating()
//            self.tags = tags
//            print(tags)
//            self.TagsCollectionView.reloadData()
//        }

   // MARK: Actions.....
    }

}
extension TagsVC {
    func setupView(){
        self.navigationController?.isNavigationBarHidden = false
      
        TagsCollectionView.dataSource = self
        TagsCollectionView.delegate = self
        
    }
    func loclized(){
        
    }
    func setUpdata(){
        
    }
    func fetchdata(){
//        loaderView.startAnimating()
//        PostAPI.getAllTags { response in
//            self.tags = response
//            self.TagsCollectionView.reloadData()
//            self.loaderView.stopAnimating()
//        }
        
    
   
        
    }
}
extension TagsVC : UICollectionViewDelegate , UICollectionViewDataSource  ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TagsCollectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionView", for: indexPath) as!  TagsCVC
        let currenTag = tags[indexPath.row]
        cell.Title.text = currenTag
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedtags = tags[indexPath.row]
        let vc = HomeVC.instantiate()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.navigationItem.backButtonTitle = ""
        vc.tag = selectedtags
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
        
     
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return .init(width: (self.TagsCollectionView.frame.width-45)/3, height: 158)
    }

    
    
    
}
