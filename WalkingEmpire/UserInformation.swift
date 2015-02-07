
//
//  UserInformation.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/11/22.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

var UserInfo: UserInformation = UserInformation()

class UserInformation: NSObject {
   
    var name: String = ""
    var userid: String = ""
    var accessToken: String = ""

    func setUp(){
        
        var data:[String: AnyObject] = DataManager.getUserInfo()
        name = data["name"] as String
        userid = data["userid"] as String
        accessToken = data["accessToken"] as String
        
    }
    
    func upadateUserInfo(){
        var data:[String: AnyObject] = ["name": name, "userid": userid, "accessToken": accessToken]
        DataManager.saveUserInfoToLocal(data)
    }
    
    func logout(){
        var data:[String: AnyObject] = ["name":"","accessToken":"","userid":""]
    }
    
    func isLogined()->Bool{
        
        if name == "" && userid == ""{
            return false
        }else{
            return true
        }
        
    }
}
