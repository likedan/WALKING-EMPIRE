//
//  MyBase.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/13.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit
import CoreLocation

class OthersObjects: GMSGroundOverlay{
    
}

class BuildingCircle: GMSCircle{
    init(position: CLLocationCoordinate2D, radius: CLLocationDistance, map:GMSMapView) {
        super.init()
        self.position = position
        self.radius = radius
        self.map = map
        self.strokeColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.8)
        self.strokeWidth = 0.1
        self.fillColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.3)
        self.tappable = false
    }

}