//
//  StepCounter.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/13.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit
import CoreMotion

var steps: StepCounter = StepCounter()


class StepCounter: NSObject {
    var stepCounter: CMStepCounter!
    var activityManager: CMMotionActivityManager!
    var timer: NSTimer!
    
    var viewController: ViewController!
    
    //The counter used to calculate motion time
    var count: Int = 0
    
    var state: String = "unknown"
    
    //set up the step counter, return false if it is not awailable(iphone 5S+)
    func setup()->Bool{
        if CMStepCounter.isStepCountingAvailable() && CMMotionActivityManager.isActivityAvailable(){
            
            viewController = AppDelegate.controller
            
            start()
            
            return true
            
        }else{
            return false
        }
    }
    
    // start counting the steps
    func start(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("startCounting"), userInfo: nil, repeats: true)
        self.timer.fire()

        var operationQueue = NSOperationQueue()
        
        //renew the data
        //count step
        /*
        stepCounter = CMStepCounter()
        
        stepCounter.startStepCountingUpdatesToQueue(operationQueue, updateOn: 1, withHandler:
            {numberOfSteps, timeStamp, error in
                if error==nil {
                    let myStep = numberOfSteps
                    println("\(myStep) 歩")
                    sleep(5)
                }
        })
        */
        activityManager = CMMotionActivityManager()
        activityManager.startActivityUpdatesToQueue(operationQueue, withHandler: {activity in

            let act: CMMotionActivity = activity as CMMotionActivity
            
            // set the new states according to M7

            if act.stationary{
                self.state = "stationary"
            }else if act.walking{
                self.state = "walking"
            }else if act.running{
                self.state = "running"
            }else if act.unknown{
                self.state = "unknown"
            }else if act.cycling{
                self.state = "cycling"
            }else if act.automotive{
                self.state = "automotive"
            }
            
            println(self.state)
            
            self.manageNewState()
            
        })
        
    }

    func calculateRate(theState: String, count: Int){
        
        if theState == "walking"{
            Resources.addResources(count * 3)
        }else if theState == "running"{
            Resources.addResources(count * 7)
        }else if theState == "cycling"{
            Resources.addResources(count * 5)
        }else if theState == "automotive"{
            Resources.addResources(count)
        }
    }
    
    //update the state change
    func manageNewState(){
        
        self.calculateRate(self.state, count: self.count)
        self.count = 0
        
        //display the new state
        dispatch_async(dispatch_get_main_queue(), {
            
            // DO SOMETHING ON THE MAINTHREAD
            self.viewController.state.text = self.state
        })
        
    }
    
    //start counting moveing time
    func startCounting(){
        count++
        println(count)
        if count > 5 && (state == "walking" || state == "running" || state == "cycling" || state == "automotive"){
            manageNewState()
        }
    }
    
}
