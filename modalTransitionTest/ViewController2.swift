//
//  ViewController2.swift
//  modalTransitionTest
//
//  Created by James An on 12/15/15.
//  Copyright © 2015 Jamesan. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    deinit{
      print("vc2 deallocated")
    }
    
    class func getVC()  -> ViewController2{
       
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("test2") as? ViewController2
            return vc!
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(){
        
       dismissViewControllerAnimated(true, completion: nil)
        
    }
   

}
