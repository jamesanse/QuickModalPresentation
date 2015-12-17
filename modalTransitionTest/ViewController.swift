//
//  ViewController.swift
//  modalTransitionTest
//
//  Created by James An on 12/15/15.
//  Copyright © 2015 Jamesan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var modalPresenter : ModalVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentStandard(){
      
        let destinationVC = ViewController2.getVC()
        modalPresenter = presentAnimtedViewController(destinationVC, frame: CGRect(x: 0, y: 0, width: 300, height: 300),style:.standard)
        
    }

    @IBAction func presentRotation(){
    
        let destinationVC = ViewController2.getVC()
        modalPresenter = presentAnimtedViewController(destinationVC, frame: CGRect(x: 0, y: 0, width: 300, height: 300),style:.rotate)
    
    }
    
    @IBAction func presentShrink(){
      
        let destinationVC = ViewController2.getVC()
        modalPresenter = presentAnimtedViewController(destinationVC, frame: CGRect(x: 0, y: 0, width: 300, height: 300),style:.shrink)
    
    }
    
    @IBAction func presentFade(){
       
        let destinationVC = ViewController2.getVC()
        modalPresenter = presentAnimtedViewController(destinationVC, frame: CGRect(x: 0, y: 0, width: 300, height: 300),style:.fade)
       
    }
    
}

