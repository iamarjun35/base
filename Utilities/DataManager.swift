//
//  DataManager.swift

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import Toast_Swift

public let CAlertTitle = NSLocalizedString("AppName", comment: "message")
public let CUnKnownError = NSLocalizedString("Something Went Wrong", comment: "message")
public let CInternetConnection = NSLocalizedString("Something wrong with internet connection", comment: "message")

let sharedInstance = web()

class web {
    //MARK: - WebServices Post Method
    func dataTaskPost(controller:UIViewController,request: String,isHeaderRequired:Bool,params: [String:Any]?, completion: @escaping (_ json:JSON) -> ()) {
        
        var headerParm : HTTPHeaders = [:]
        if isHeaderRequired == true{
            headerParm = sendToken()
        }
        if (NetworkReachabilityManager()?.isReachable)!{
            AF.request(request, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headerParm).responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    completion(json)
                case .failure(let error):
                    self.hideHudd()
                    if let data = response.data, let errorString = String(data: data, encoding: .utf8){
                        AGApiLog.debug("\(request) Server Error: \n\(errorString)")
                    }
                    controller.view?.makeToast(error.localizedDescription, duration: 3, position: .bottom)
                }
            }
        }else{
            self.hideHudd()
            controller.view?.makeToast("Check Your Internet", duration: 3, position: .bottom)
        }
    }
    
    func dataTaskPostMapper(controller:UIViewController,request: String,isHeaderRequired:Bool,params: [String:Any]?, completion: @escaping (_ json:AnyObject) -> ()) {

        var headerParm : HTTPHeaders = [:]
        if isHeaderRequired == true{
            headerParm = sendToken()
        }
        if (NetworkReachabilityManager()?.isReachable)!{
            AF.request(request, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headerParm).responseJSON { (response) in
                
                switch response.result {
                case .success(let data):
                    completion(data as AnyObject)
                case .failure(let error):
                    self.hideHudd()
                    if let data = response.data, let errorString = String(data: data, encoding: .utf8){
                        AGApiLog.debug("\(request) Server Error: \n\(errorString)")
                    }
                    controller.view?.makeToast(error.localizedDescription, duration: 3, position: .bottom)
                }
            }
        }else{
            self.hideHudd()
            controller.view?.makeToast("Check Your Internet", duration: 3, position: .bottom)
        }
    }
    
    func sendToken() -> HTTPHeaders{
        if UserDetails.shared.token.trimSpace().length() != 0{
            let header = HTTPHeader.init(name: AppKey.Usertoken, value: UserDetails.shared.token)
            return HTTPHeaders.init([header])
        }
        return HTTPHeaders.init()
    }
    
    //    func logout(controller:UIViewController){
    //
    //        let alert = UIAlertController(title: KAlertTitle, message: "Please login again", preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
    //            UIApplication.shared.unregisterForRemoteNotifications()
    //
    //            if UserDetails.shared.isLogin(){
    //                UserDetails.shared.logout()
    //            }
    //            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //            let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    //            let navVC = SwipeNavigationController(rootViewController: nextVC)
    //            navVC.navigationBar.isHidden = true
    //            KAppDelegate.window?.rootViewController = navVC
    //        }))
    //        controller.present(alert, animated: true, completion: nil)
    //    }
    
    func showHudd(){
        //        SVProgressHUD.show()
        //        SVProgressHUD.setDefaultMaskType(.clear)
        let size = CGSize(width: 50, height: 50)
        let bgColor = UIColor.black.withAlphaComponent(0.35)
        let activityData = ActivityData(size: size, message: "", messageFont: nil, messageSpacing: nil, type: .ballScaleRippleMultiple, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: bgColor, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
    }
    
    func hideHudd(){
        //        SVProgressHUD.dismiss()
        //        SVProgressHUD.setDefaultMaskType(.none)
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }
    
    
    //MARK: - WebServices Get Method
    func dataTaskGet(controller:UIViewController,request: String,params: [String:Any]?,isHeaderRequired:Bool, completion: @escaping (_ json:JSON) -> ()) {
        var headerParm : HTTPHeaders = [:]
        if isHeaderRequired == true{
            //            headerParm = ["Usertoken":UserDetails.shared.token,"Content-Type":"application/json"]
            headerParm = sendToken()
        }
        if (NetworkReachabilityManager()?.isReachable)!{
            AF.request(request, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headerParm).responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    completion(json)
                case .failure(let error):
                    self.hideHudd()
                    if let data = response.data, let errorString = String(data: data, encoding: .utf8){
                        AGApiLog.debug("\(request) Server Error: \n\(errorString)")
                    }
                    controller.view?.makeToast(error.localizedDescription, duration: 3, position: .bottom)
                }
            }
        } else {
            controller.view?.makeToast("Check Your Internet", duration: 3, position: .bottom)
            self.hideHudd()
        }
    }
    
    //MARK: - MULTIPART WEB SERVICE
    func uploadMediaToServer(controller:UIViewController,url:String,imgMedia:[String:Data],params:[String:AnyObject]?,header:HTTPHeaders,videoMedia:[String:Data],completion:@escaping (JSON) -> Void,failure:@escaping (String)  -> Void){
        let fullPath = url
        
        var url = try! URLRequest.init(url: fullPath, method: .post, headers: header)
        url.timeoutInterval = 180
        
        let imgMimeType : String = "image/jpeg"
        let imgFileName = "\(UUID().uuidString).jpeg"
        
        let  videoMimeType = "video/mp4"
        let  videoFileName = "b.mp4"
        
        if (NetworkReachabilityManager()?.isReachable)!{
            AF.upload(multipartFormData: { formdata in
                if let params = params{
                    for (key, value) in params {
                        formdata.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }
                for (key,value) in imgMedia{
                    formdata.append(value, withName: key, fileName: imgFileName, mimeType: imgMimeType)
                }
                for (key,value) in videoMedia{
                    formdata.append(value, withName: key, fileName: videoFileName, mimeType: videoMimeType)
                }
            }, with: url)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: { response in
                    //Do what ever you want to do with response
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        completion(json)
                    case .failure(let error):
                        self.hideHudd()
                        if let data = response.data, let errorString = String(data: data, encoding: .utf8){
                            AGApiLog.debug("Server Error: \n\(errorString)")
                        }
                        controller.view?.makeToast(error.localizedDescription, duration: 3, position: .bottom)
                    }
                })
        }else {
            controller.view?.makeToast("Check Your Internet", duration: 3, position: .bottom)
            self.hideHudd()
        }
    }
    
    func asURLRequest(urlString:String) throws -> URLRequest {
        let url = try urlString.asURL()

        let urlRequest = URLRequest(url: url)

        return urlRequest
    }
    
    
}



