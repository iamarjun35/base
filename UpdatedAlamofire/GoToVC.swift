//
//  GoToVC.swift
//  MoyaDemo
//
//  Created by IOS on 14/07/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper


class GoToVC: UIViewController {
    
    var arrModels = [GetVehicleModelData]()
    var makeID = String()
    
    @IBOutlet weak var tblViw: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let params = ["make_id":makeID]
        webServices(params, API.getVehicleModelByMakeId, API.getVehicleModelByMakeId)
    }
    
    func webServices(_ parameter: [String:Any],_ apiURL: String,_ type: String){
        self.showHudd()
        sharedInstance.dataTaskPostMapper(controller: self,request: apiURL,isHeaderRequired:true, params: parameter, completion: {
            result in
            self.hideHudd()
            let json = JSON(result)
            let code = json["statusCode"].intValue
            let msg = json["message"].stringValue
            print("\(apiURL) response: \(json)")
            if code == 200{
                let responseModel = Mapper<GetVehicleModelBase>().map(JSONObject: result)
                if let data = responseModel?.data{
                    self.arrModels.removeAll()
                    self.arrModels = data
                    self.tblViw.reloadData()
                }
            }
            if code == 400{
                self.view.makeToast(msg, duration: 3, position: .center)
            }
        })
    }
    

}

extension GoToVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = arrModels[indexPath.row].model_name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrModels[indexPath.row].model_id ?? "")
    }
        
}
