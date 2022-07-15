//
//  Route.swift
//  Social_App
//
//  Created by ezz on 09/07/2022.
//

import Foundation
enum Route {
    static let  BaseURL = "https://dummyapi.io/data/v1"
    case fetchAllPosts
    case fetchComments(String)
    case fetchUserInfo(String)
    case fetchCreatNewUser
    case fetchPostsByTag(String)
    case fetchcreateNewPost
    case FetchUpdateUser(String)
    
    var descreption : String
    {
        switch self {
        case .fetchAllPosts: return "/post"
        case .fetchComments(let id) :  return "/post/\(id)/comment"
        case .fetchUserInfo(let id ) : return "/user/\(id)"
        case .fetchCreatNewUser : return "/user/create"
        case .fetchPostsByTag(let tag) : return "/tag/\(tag)/post"
        case .fetchcreateNewPost : return "/post/create"
        case .FetchUpdateUser(let id)  :return "/user/\(id)"
        }
        
    }
}
