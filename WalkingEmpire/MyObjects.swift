//
//  MyGeneral.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/13.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit
import CoreLocation

class MyObjects: GMSMarker {
    
    init(longitude: CLLocationDistance, latitude: CLLocationDistance, map: GMSMapView){
        super.init()
        self.map = map
        self.appearAnimation = kGMSMarkerAnimationPop
        self.position = CLLocationCoordinate2DMake(latitude, longitude)
        self.groundAnchor = CGPointMake(0.5, 0.5)
    }
    

}

class MyGeneral: MyObjects{
    
    var level:Int = 0
    
    override init(longitude: CLLocationDistance, latitude: CLLocationDistance, map: GMSMapView){
        
        super.init(longitude: longitude, latitude: latitude, map: map)
        self.icon = ImageManipulationFunctions.changeImageSize(UIImage(named: "UserIconCrown")!, size: CGSizeMake(50, 50))
        
    }
    
}

class MyBase: MyObjects{
    
    var level:Int = 0
    
    override init(longitude: CLLocationDistance, latitude: CLLocationDistance, map: GMSMapView){
        
        super.init(longitude: longitude, latitude: latitude, map: map)
        self.icon = ImageManipulationFunctions.changeImageSize(UIImage(named: "TowerArcane")!, size: CGSizeMake(35, 35))
        
    }
    
}

class Prebase: MyObjects{
    
    var longitudeFromCenter: CLLocationDistance!
    var latitudeFromCenter: CLLocationDistance!

    
    override init(longitude: CLLocationDistance, latitude: CLLocationDistance, map: GMSMapView){
        
        super.init(longitude: longitude, latitude: latitude, map: map)
        self.icon = ImageManipulationFunctions.changeAlpha(ImageManipulationFunctions.changeImageSize(UIImage(named: "TowerArcane")!, size: CGSizeMake(35, 35)), alpha: 0.5)
        
        longitudeFromCenter = longitude - LocationInfo.location.coordinate.longitude
        latitudeFromCenter = latitude - LocationInfo.location.coordinate.latitude

    }
    
    //change position as the position of the user changes
    func changePosition(coordinate: CLLocationCoordinate2D){
        self.position = CLLocationCoordinate2DMake(coordinate.latitude + latitudeFromCenter, coordinate.longitude + longitudeFromCenter)
    }
    
    //set to a new position
    func setLocation(coordinate: CLLocationCoordinate2D){
        self.position = coordinate
        longitudeFromCenter = coordinate.longitude - LocationInfo.location.coordinate.longitude
        latitudeFromCenter = coordinate.latitude - LocationInfo.location.coordinate.latitude
    }
    
}