//
//  AllObjectsOnMap.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/13.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

var objectsOnMap: AllObjectsOnMap = AllObjectsOnMap()

class AllObjectsOnMap: NSObject {
    
    var mapView: MapViewController!
    
    var buildPrice: BasePrice!
    var prebuildBase: Prebase!
    var constructionOverlay: BuildingCircle!
    
    var myBases: [OthersObjects] = [OthersObjects]()
    var myGeneral: MyGeneral!
    
    
    //create General and existing bases
    
    func setup(location: CLLocation){
        
        mapView = LocationInfo.viewController.mapView
        
        myGeneral = MyGeneral(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, map: mapView.map)
        mapView.mapCenter = myGeneral
        
        mapView.setToCenter(false)
        
        // set up the construction overlay
        
    }
    
    //update the position of  the objects according to the displacement of the user
    func updateAllPosition(location: CLLocation){
        myGeneral.position = location.coordinate
        if constructionOverlay != nil{
            constructionOverlay.position = myGeneral.position
        }
        if prebuildBase != nil{
            prebuildBase.changePosition(location.coordinate)
        }
    }
    
    //set new Location for Prebase  if not exist create one
    func managePrebase(coordinate: CLLocationCoordinate2D){
        
        println(coordinate.latitude)
        
        //check if the coordinate is within the boundary, change the location of the prebase
        
        if MathFunctions.calculateCoordinateDistanceOfTwoPoints(coordinate, coordinate2: LocationInfo.location.coordinate) < 0.4{
            if prebuildBase == nil{
                prebuildBase = Prebase(longitude: coordinate.longitude, latitude: coordinate.latitude, map: mapView.map)
                mapView.mapCenter = prebuildBase

                buildPrice = NSBundle.mainBundle().loadNibNamed("BasePrice", owner: 0, options: nil)[0] as? BasePrice
                buildPrice.center = CGPointMake(mapView.view.center.x + buildPrice.frame.width / 2, mapView.view.center.y - buildPrice.frame.height)
                //buildPrice.cancel.addTarget(target: AnyObject?, action: <#Selector#>, forControlEvents: <#UIControlEvents#>)
                
                mapView.view.addSubview(buildPrice)
            }else{
                prebuildBase.setLocation(coordinate)
                
            }
        }
    }
    
}
