//import UIKit
//import Alamofire
//
//class WebService: NSObject{
//
//    static let shared = WebService()
//
//    func sendRequest(url:String, params: [String:Any]? = [:], method: RMethod, isAuth: Bool, completion:((AFDataResponse<Any>,Error?)->Void)!) {
//
//        let headers: HTTPHeaders = [:]
//        if isAuth {
//
////            headers = ["Authorization": "Bearer \(Helper.access_token)"]
////            headers["accept"]     = "application/json"
////            headers["Content-Type"]     = "application/json"
//
//
//        }
////        headers["X-local"]    = Language.currentLanguage()
//        var _method: HTTPMethod!
//
//        if method == .get {
//            _method = .get
//        } else if method == .post{
//            _method = .post
//        }else{//delete
//            _method = .delete
//        }
//
//        AF.request(url, method: _method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
//            print(response)
//            switch response.result {
//            case .success(_):
//                completion(response,nil)
//            case .failure(let fail):
//                completion(response,fail)
//            }
//        }
//
//    }
//
//
//    func uploadImage(url: String, imageData: Data?, parameters: [String : Any],  completion:((AFDataResponse<Any>,Error?)->Void)!){
//        var headers: HTTPHeaders = [:]
//        headers = [
//            "Accept": "application/json",
//            "Content-type": "multipart/form-data"
//        ]
//
//        AF.upload(multipartFormData: { multipartFormData in
//
//            for (key, value) in parameters {
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray {
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//
//            if let data = imageData{
//                multipartFormData.append(data, withName: "file", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
//            }
//        },
//                  to: url, method: .post , headers: headers)
//            .responseJSON(completionHandler: { (response) in
//
//                print(response)
//                switch response.result {
//                case .success(_):
//                    completion(response,nil)
//                case .failure(let fail):
//                    completion(response,fail)
//                }
//
//
//            })
//    }
//}
//enum RMethod {
//    case post
//    case get
//    case delete
//}
