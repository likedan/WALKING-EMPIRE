//
//  DataManager.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/11/22.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

class DataManager: NSObject {
   
    class func initializeUserInfo(){
        
        let fileManager = NSFileManager()
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        path = path.stringByAppendingPathComponent("UserInformation.plist")
        let resource = NSBundle.mainBundle().pathForResource("UserInformation", ofType: "plist") as String?
        
        var dict = NSDictionary(contentsOfFile: resource!)
        fileManager.copyItemAtPath(resource!, toPath: path, error: nil)
        
    }
    
    class func getUserInfo()->[String: AnyObject]{
        
        let fileManager = NSFileManager()
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        path = path.stringByAppendingPathComponent("UserInformation.plist")
        
        let dict = NSDictionary(contentsOfFile: path)

        return dict as [String: AnyObject]
        
    }
    
    class func saveUserInfoToLocal(info: [String: AnyObject]){
                
println(info)

        let fileManager = NSFileManager()
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        path = path.stringByAppendingPathComponent("UserInformation.plist")
        
        let dict : NSDictionary = info
        dict.writeToFile(path, atomically: true)
        
    }
    
}
