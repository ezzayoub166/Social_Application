//
//  PostAPI.swift
//  Social_App
//
//  Created by ezz on 09/07/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI : API {

    static func getAllPosts(page : Int ,completionHandler : @escaping ([Post] , Int) -> () , route : Route){  // completionHandler هي عبارة عن بارميتر يمثل دالة يتم تنفيذها واستدعائها من داخل الدالة ...
        let url = Route.BaseURL + route.descreption
        let parms = ["page" : "\(page)" , "limit" : "5"]
        AF.request(url , parameters: parms , encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue // Convert from Json to Integer
            let decoder = JSONDecoder()
            do {
                // posts fill the response come by Request ....
                // posts is about the array
                let posts = try decoder.decode([Post].self, from: data.rawData()) //convert the array of objects tybe jason ..to array of objects from Post Tybe
                completionHandler(posts , total) //
            }
            catch let error {
                print(error)
            }
        }
    }
    
    // MARK: get All posts By Specfic Tag
    static func getAllPostsByTag(completionHandler : @escaping ([Post]) -> () , route : Route){  // completionHandler هي عبارة عن بارميتر يمثل دالة يتم تنفيذها واستدعائها من داخل الدالة ...
        let url = Route.BaseURL + route.descreption
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                // posts fill the response come by Request ....
                // posts is about the array
                let posts = try decoder.decode([Post].self, from: data.rawData()) //convert the array of objects tybe jason ..to array of objects from Post Tybe
                completionHandler(posts) //
            }
            catch let error {
                print(error)
            }
        }
    }
    
    
    static func getCommentsOfPosts(completionHandler : @escaping ([Comment]) -> () , route : Route){
//        let url = "https://dummyapi.io/data/v1/post/\(id)/comment"
        let url = Route.BaseURL + route.descreption
        AF.request(url , headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let comments = try decoder.decode([Comment].self, from: data.rawData()) //convert the array of objects tybe jason ..to array of objects from Post Tybe
                //بعد ما تكون جهوت الريسبونس وجبت الداتا وبنيت الكومنتس ...استدعليلي الكومللشن هاندلر عشان نصل لبعد هاي النقطة ونقدر نحدث المصفوفة ونحدث التابل فيو
              //  اي كل اشي بيحتاجه الفيو كونترولر قدمله اياه على طبق من ذهببببببب
                completionHandler(comments)
            }
            
            catch let error {
                print(error)
            }
        }
    }
    static func getAllTags(completionHandler : @escaping ([String]) -> ()) {
        let url = "https://dummyapi.io/data/v1/tag"
        AF.request(url , headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let decoder = JSONDecoder()
                do{
                    let tags = try decoder.decode([String].self, from :data.rawData())
                    completionHandler(tags)
                }
                catch let error {
                    print("Some Proplem in Decodeing , \(error)")
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    static func AddNewPost (message : String , UserID :String , picture : String  , completionHandler : @escaping () -> () , route : Route ) {
        var parms = [
               "owner": UserID,
               "text": message,
               "picture" : picture
        ]
        let url = Route.BaseURL + route.descreption
        
        AF.request(url, method: .post, parameters: parms, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { commentResponse in
            switch commentResponse.result {
            case .success:
                 completionHandler()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    }
