//
//  IndividualViewController.swift
//  Mailbox
//
//  Created by Jessica Jarvis on 9/25/14.
//  Copyright (c) 2014 Jessica Jarvis. All rights reserved.
//

import UIKit

class IndividualViewController: UIViewController {

    @IBOutlet var panGest: UIPanGestureRecognizer!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    
    @IBOutlet weak var laterIcon: UIImageView!
    
    @IBOutlet weak var singleMessage: UIImageView!
    
    var imageCenter: CGPoint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // pan gesture function
    @IBAction func onPanMessage(sender: UIPanGestureRecognizer) {
        
        // pan gesture vars
        var location = panGest.locationInView(view)
        var translation = panGest.translationInView(view)
        var velocity = panGest.velocityInView(view)
        
        
        // pan gesture states
        if panGest.state == UIGestureRecognizerState.Began {
            imageCenter = singleMessage.center
            
        } else if panGest.state == UIGestureRecognizerState.Changed {
            singleMessage.center.x = translation.x + imageCenter.x
            // singleMessage.center.y = translation.y + imageCenter.y
            
        } else if panGest.state == UIGestureRecognizerState.Ended {

        }
        
    }

}
