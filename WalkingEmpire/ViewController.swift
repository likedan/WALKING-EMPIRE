//
//  ViewController.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/12.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mapView : MapViewController!
    var resourcesView : ResourcesViewController!

    @IBOutlet var state : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = self.childViewControllers[0] as MapViewController
        resourcesView = self.childViewControllers[1] as ResourcesViewController

        //self.view = mapView
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

