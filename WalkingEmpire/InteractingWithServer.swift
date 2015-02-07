//  InteractingWithServer.swift
//  NBillBoard
//
//  Created by Kedan Li on 14-10-1.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

class InteractingWithServer: NSObject {
    
    
    class func getServerAddress() -> String{
        
        return "http://104.236.3.152"
        
    }
    
    class func login()->Bool{
        
        var result:[String: AnyObject] = [String: AnyObject]()
        
        let info :[String: AnyObject] = ["userid": UserInfo.userid, "token": UserInfo.accessToken]
        
        result = InteractingWithServer.connectSynchoronous("/login", info: info, method:"POST")
        return result["success"] as Bool
    }
    
    class func checkCookie()->Bool{
    
        var result:[String: AnyObject] = [String: AnyObject]()
        result = InteractingWithServer.connectSynchoronous("/check_cookie", info: result, method:"POST")
        return result["success"] as Bool

    }

    class func updateLocation(){
        
        var result:[String: AnyObject] = [String: AnyObject]()
        let info :[String: AnyObject] = ["latitude": LocationInfo.getCurrentLocation()!.coordinate.latitude, "longitude": LocationInfo.getCurrentLocation()!.coordinate.longitude]
        InteractingWithServer.connectASynchoronous("/update_location", info: info, method:"POST")

    }
    
    class func addBase(coordinate: CLLocationCoordinate2D)->String{
        var result:[String: AnyObject] = [String: AnyObject]()
        let info :[String: AnyObject] = ["latitude": coordinate.latitude, "longitude": coordinate.longitude]
        
        result = InteractingWithServer.connectSynchoronous("/add_base", info: info, method:"POST")
        
        if result["success"] as Bool{
            return result["baseID"] as String
        }else {
            return "failed"
        }

    }
    
    class func connectSynchoronous(suffix: String ,info:[String: AnyObject], method:String)-> [String:AnyObject]{
        
        var result:[String: AnyObject] = [String: AnyObject]()
        
        var request = NSMutableURLRequest(URL: NSURL(string: InteractingWithServer.getServerAddress() + suffix)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        
        var error: NSError?
        
        // create some JSON data and configure the request
        var jsonData: NSData = NSJSONSerialization.dataWithJSONObject(info, options: NSJSONWritingOptions.PrettyPrinted, error: &error)!

        request.HTTPBody = jsonData//jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //println(request.description)
        var returnData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: &error)!
        if (error == nil){
            
            var data = NSString(data: returnData, encoding: NSASCIIStringEncoding)
            
            //println(data)
                //var returnData = httpResponse.textEncodingName!.dataUsingEncoding(NSUTF8StringEncoding)
            var jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.AllowFragments, error: &error)
            

            if jsonObject != nil{
                result = jsonObject as [String: AnyObject]
                
                //println(result)
                
                if result["success"] as Bool{
                    
                }else {
                    result.updateValue(false, forKey: "success")
                    result.updateValue(result["comment"] as String, forKey: "error")
                }
            }else{
                result.updateValue(false, forKey: "success")
            }
            
        }else{
            result.updateValue(false, forKey: "success")
        }
        return result
    }
    
    class func connectASynchoronous(suffix: String ,info:[String: AnyObject], method:String){
        
        var result:[String: AnyObject] = [String: AnyObject]()
        
        var request = NSMutableURLRequest(URL: NSURL(string: InteractingWithServer.getServerAddress() + suffix)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 15)
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        
        var error: NSError?
        
        // create some JSON data and configure the request
        var jsonData: NSData = NSJSONSerialization.dataWithJSONObject(info, options: NSJSONWritingOptions.PrettyPrinted, error: &error)!
        
        println(jsonData.description)
        
        request.HTTPBody = jsonData//jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //println(request.description)

        var queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            if data != nil && data.length > 0 && error == nil{
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    
                    var error: NSError?
                    
                    var jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
                    result = jsonObject as [String: AnyObject]!
                    
                    println(result)
                    
                    if result["success"] as Bool{
                        
                    }else {
                        result.updateValue(false, forKey: "success")
                        result.updateValue(result["comment"] as String, forKey: "error")
                    }
                }
                
            }else if error == nil{
                println("empty response")
                
            }else if error != nil{
                println(error)
                
            }
        })

    }

    
    class func getCurrentNet() -> String{
        
        var result: String?
        
        let reach = Reachability()
        var internetReachable = Reachability(hostName: "www.apple.com")
        var status: NetworkStatus = internetReachable.currentReachabilityStatus()
        
        
        if status == 0{
            result = "NO"
        }else if status == 1{
            result = "WIFI"
        }else if status == 2{
            result = "WLAN"
        }
        
        return result!
        
    }
    
    class func getIfConnected() -> Bool{
        
        var result: Bool?
        
        let reach = Reachability()
        var internetReachable = Reachability(hostName: "www.apple.com")
        var status: NetworkStatus = internetReachable.currentReachabilityStatus()
        
        if status == 0{
            result = false
        }else if status == 1{
            result = true
        }else if status == 2{
            result = true
        }
        
        return result!
        
    }
    
    
    /*
    (NSMutableDictionary*)Login:(NSString *)username password:(NSString *)password
    {
    
    NSError *error1 = [request error];
    if (!error1)
    {
    NSString *response = [request responseString];
    NSLog(@"Test：%@",response);
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization
    JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments
    error:&error];
    result = (NSMutableDictionary *)jsonObject;
    }
    }
    
    return result;
    
    }
    */
    
}
