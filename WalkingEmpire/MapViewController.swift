
//
//  MapViewController.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/12.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit


class MapViewController: UIViewController, GMSMapViewDelegate{

    @IBOutlet var mapBG: UIScrollView!
    
    @IBOutlet var addBase: UIButton!
    
    var map: GMSMapView!
    
    var mapCenter: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create the map

        var camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.23, zoom:17)
        
        map = GMSMapView.mapWithFrame(self.view.frame, camera: camera)
        map.mapType = kGMSTypeNone
        map.delegate = self
        map.setMinZoom(1, maxZoom: 18)
        map.myLocationEnabled = false
        map.indoorEnabled = false
        
        mapBG.addSubview(map)
/*
        
        var urls : GMSTileURLConstructor = {
            x,y,zoom in
            
            //var str = "http://tile.stamen.com/watercolor/\(zoom)/\(x)/\(y).jpg"
            var str = "http://api.tiles.mapbox.com/v4/likedan5.60317478/\(zoom)/\(x)/\(y).png256?access_token=pk.eyJ1IjoibGlrZWRhbjUiLCJhIjoiaXJFLW9qbyJ9.SrX6tNNlKtUDVnure_XOAQ"
            var url = NSURL(string: str)
            
            return url
        }
        
        var layer = GMSURLTileLayer(URLConstructor: urls)
*/
        var layer = CachingTileClass()
        layer.map = map
        
        // Do any additional setup after loading the view.
    }

    //set to add base mode   and switch back if it's already in
    @IBAction func createBase(sender: UIButton){
        
        if !addBase.selected{
            
            objectsOnMap.constructionOverlay = BuildingCircle(position: LocationInfo.location.coordinate, radius: 1000, map: map)
            objectsOnMap.myGeneral.tappable = false
            addBase.selected = true
            
            //set a new zoom scale
            map.animateToZoom(14)
            
        }else{

            objectsOnMap.constructionOverlay.map = nil
            objectsOnMap.constructionOverlay = nil
            if objectsOnMap.prebuildBase != nil{
                objectsOnMap.prebuildBase.map = nil
                objectsOnMap.prebuildBase = nil
            }
            addBase.selected = false
            objectsOnMap.myGeneral.tappable = true

            
        }
        
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        // move the prebase if in add base mode
        if addBase.selected{
            objectsOnMap.managePrebase(coordinate)
        }
    }
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        setToCenter(true)
        
    }
    
    //Move the map to the center
    func setToCenter(animation: Bool){
        if LocationInfo.location != nil && mapCenter != nil{
            map.animateToLocation(mapCenter.position)
        }
        
    }
    // set map userinteraction to false if in animation

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*
    //rotate according to the gesture
    func rotateMap(recognizer: UIRotationGestureRecognizer){
    
    var rotation = recognizer.rotation + mapRotation
    
    map.transform = CGAffineTransformMakeRotation(rotation)
    
    // objects on the map rotate to the opposite direction
    //objectsOnMap.objectsRotate(CGAffineTransformMakeRotation(-rotation))
    
    if recognizer.state == UIGestureRecognizerState.Cancelled || recognizer.state == UIGestureRecognizerState.Failed || recognizer.state == UIGestureRecognizerState.Ended{
    // save the current rotation
    mapRotation = rotation
    }
    }
    */

}
