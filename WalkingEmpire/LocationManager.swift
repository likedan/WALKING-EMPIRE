
//
//  LocationManager.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/11/22.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit
import CoreLocation

var LocationInfo: LocationManager = LocationManager()

class LocationManager: NSObject, CLLocationManagerDelegate{
   
    var viewController: ViewController!
    
    var location:CLLocation!
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    var acceptBound = 0.02
    
    func setup(){
        
        viewController = AppDelegate.controller
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        //For testing
        start()
    }
    
    func start(){
        
        self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        location = locations[locations.count - 1] as CLLocation

        viewController.mapView.setToCenter(true)
        
        //update the position of the general if the game has started
        if AppDelegate.gameOn{
            objectsOnMap.updateAllPosition(location)
        }else{
            // just for testing
            AppDelegate.startGame()
        }
        
    }
    /*
    func changeAcceptBound(zoomLevel: Double){
        acceptBound = 2 * pow(2, 18 - zoomLevel) / 100
    }
    */

    

    // get the latest location stored in the phone
    func getCurrentLocation()->CLLocation?{
        if location != nil{
            return location
        }else{
            return nil
        }
    }
    
}
