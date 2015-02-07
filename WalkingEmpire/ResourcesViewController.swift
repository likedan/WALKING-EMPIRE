//
//  ResourcesViewController.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/11/22.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    @IBOutlet var money: UILabel!
    @IBOutlet var resource: UILabel!
    @IBOutlet var population: UILabel!
    
    @IBOutlet var moneyPicture: UIButton!
    @IBOutlet var resourcePicture: UIButton!
    @IBOutlet var populationPicture: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateResources(){
        money.text = "\(Int(Resources.money))"
        resource.text = "\(Int(Resources.naturalResources))"
        population.text = "\(Resources.population)"

    }
    
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

}
