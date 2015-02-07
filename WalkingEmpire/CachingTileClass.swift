//
//  MyTileClass.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/15.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

import Haneke

class CachingTileClass: GMSSyncTileLayer {
    
    struct A_Kludge_Swift_Are_You_Kidding_Me_Why_Cannot_Use_Class_Variables {
        static var thread_local_storage:ThreadLocalSlot<dispatch_semaphore_t> = ThreadLocalSlot<dispatch_semaphore_t>()
    }
    
    private class var thread_local_storage : ThreadLocalSlot<dispatch_semaphore_t>
    {
        get {return A_Kludge_Swift_Are_You_Kidding_Me_Why_Cannot_Use_Class_Variables.thread_local_storage}
        set {A_Kludge_Swift_Are_You_Kidding_Me_Why_Cannot_Use_Class_Variables.thread_local_storage = newValue}
    }
    
    override func tileForX(x: UInt, y: UInt, zoom: UInt) -> UIImage! {
        
        if CachingTileClass.thread_local_storage.value == nil {
            CachingTileClass.thread_local_storage.value = dispatch_semaphore_create(0) as NSObject
        }
        let semaphore = CachingTileClass.thread_local_storage.value
        
        let cache = Shared.dataCache
        
        let key: String = "x:" + "\(x)" + "y:" + "\(y)" + "zoom:" + "\(zoom)"
        
        var layerImg: UIImage!
        //check if has store data

        var str = "http://tile.stamen.com/watercolor/\(zoom)/\(x)/\(y).jpg"
        var url = NSURL(string: str)
        
        cache.fetch(URL: url!).onSuccess { image in
            //println(image.description)
            layerImg = UIImage(data: image)
            
            dispatch_semaphore_signal(semaphore!);
        }
        
        dispatch_semaphore_wait(semaphore!, DISPATCH_TIME_FOREVER);
        
        return layerImg
    }

}
