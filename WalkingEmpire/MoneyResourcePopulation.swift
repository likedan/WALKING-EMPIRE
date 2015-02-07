
//
//  MoneyResourcePopulation.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/11/22.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

var Resources: MoneyResourcePopulation = MoneyResourcePopulation()

class MoneyResourcePopulation: NSObject {
    
    var resourcesController: ResourcesViewController!
    
    //total amount of these kinds of resources
    var money: Double = 0
    var naturalResources: Double = 0
    
    var population: Int = 0

    //adding rate of these kind of resources
    var moneyRate = 1.5
    var naturalResourcesRate = 0.8
    
    func setValues(moneyy: Double, populations: Int, resource: Double){
        money = moneyy
        population = populations
        naturalResources = resource
        
        resourcesController = AppDelegate.controller.resourcesView
        
        resourcesController.updateResources()

    }
    
    //increase the natural resources and money acoording to motion
    func addResources(counter: Int){
        money = money + Double(counter) * moneyRate
        naturalResources = naturalResources + Double(counter) * naturalResourcesRate
        
        //update the resources on the view
        dispatch_async(dispatch_get_main_queue(), {
            
            // DO SOMETHING ON THE MAINTHREAD
            self.resourcesController.updateResources()
        })
    }
    
}
