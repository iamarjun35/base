//
//  MultipartVC.swift
//  UpdatedAlamofire
//
//  Created by IOS on 16/07/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SwiftyJSON

class MultipartVC: BaseClass {
    
    @IBOutlet weak var btnImg: UIButton!
    @IBOutlet weak var txtFn: UITextField!
    @IBOutlet weak var txtLn: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func webServices(_ parameter: [String:Any],_ apiURL: String,_ type: String) {
        let imgData = btnImg.currentImage?.jpegData(compressionQuality: 0.5) ?? Data()
        self.showHudd()
        sharedInstance.uploadMediaToServer(controller: self, url:apiURL, imgMedia: [AppKey.profile_image:imgData], params: parameter as [String : AnyObject], header: [:], videoMedia: [:], completion: { (result) in
            self.hideHudd()
            let json = JSON(result)
            let code = json["statusCode"].intValue
            let msg = json["message"].stringValue
            print("\(apiURL) response: \(json)")
            if code == 200{
                self.alertView(controller: self, title: KAlertTitle, msg: msg)
            }
            if code == 201 || code == 400{
                self.view.makeToast(msg, duration: 3, position: .center)
            }
        }, failure: {error in
            print(error)
            self.hideHudd()
            self.view.makeToast(error, duration: 3, position: .center)
        })
    }
    
    @IBAction func changeImage(_ sender: Any) {
        openCameraAndPhotos(isEditImage: true, getImage: { (image, str) in
            
            self.btnImg.setImage(image, for: .normal)
            
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let params = [AppKey.firstName:txtFn.text!,AppKey.lastName:txtLn.text!,AppKey.password:txtPass.text!,AppKey.sex:"Male",AppKey.email:txtEmail.text!]
        webServices(params, API.signup, API.signup)
    }
    


}
