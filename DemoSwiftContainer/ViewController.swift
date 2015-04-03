//
//  ViewController.swift
//  DemoSwiftContainer
//
//  Created by Julien DAUPHANT on 03/04/15.
//  Copyright (c) 2015 Siz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    var currentControllerIdentifier: String? {
        didSet {
            println("Current identifier : \(currentControllerIdentifier)")
        }
    }
    weak var currentController: UIViewController?


    @IBAction func changeController() {
        var newControllerIdentifier: String
        switch currentControllerIdentifier {
            case .Some("first") : newControllerIdentifier = "second"
            case .Some("second") : newControllerIdentifier = "first"
            default: newControllerIdentifier = "first"
        }
        
        if var newController = storyboard?.instantiateViewControllerWithIdentifier(newControllerIdentifier) as? UIViewController {
            newController.view.frame = currentController!.view.frame
            self.addChildViewController(newController)
            self.willMoveToParentViewController(nil)       
            self.transitionFromViewController(currentController!,
                toViewController: newController,
                duration: 0.0, options: nil,
                animations: nil,
                completion: { (finished) in
                    self.currentController?.removeFromParentViewController()
                    self.currentController = newController
                    self.currentControllerIdentifier = newControllerIdentifier
                    newController.didMoveToParentViewController(self)
                }
            )
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let currentController = segue.destinationViewController as? UIViewController {
            self.currentController = currentController
            self.currentControllerIdentifier = "first"
        }
    }
    
}

