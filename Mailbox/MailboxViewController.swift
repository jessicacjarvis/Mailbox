//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Jessica Jarvis on 9/24/14.
//  Copyright (c) 2014 Jessica Jarvis. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var mailboxScrollView: UIScrollView!
    

    // OUTLETS
    @IBOutlet var panGest: UIPanGestureRecognizer!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var singleMessage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    // VARS
    var imageCenter: CGPoint!
    var laterIconCenter: CGPoint!
    var archiveIconCenter: CGPoint!
    var deleteIconCenter: CGPoint!
    var listIconCenter: CGPoint!
    var buildScroll = 0
    
    // COLORS
    let mailboxGray = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1)
    let mailboxYellow = UIColor(red: 0.976, green: 0.824, blue: 0.275, alpha: 1)
    let mailboxGreen = UIColor(red: 0.455, green: 0.843, blue: 0.408, alpha: 1)
    let mailboxBrown = UIColor(red: 0.843, green: 0.647, blue: 0.471, alpha: 1)
    let mailboxRed = UIColor(red: 0.914, green: 0.333, blue: 0.231, alpha: 1)
    

    
    // LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // SCROLL VIEW ON LOAD
        mailboxScrollView.contentSize = CGSize(width: 320, height: 1367)

        
    }
    
    // APPEAR
    override func viewDidAppear(animated: Bool) {
        if buildScroll > 0 {
            delay(0.1, closure: { () -> () in
                self.scrollAdjust()
                self.delay(0.3, closure: { () -> () in
                    self.messageView.hidden = true
                })
            })
        }
    }

    // RANDOM XCODE FUNCTION
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // FUNCTION FOR ADJUSTING SCROLL VIEW
    func scrollAdjust() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedImage.transform = CGAffineTransformMakeTranslation(self.feedImage.frame.origin.x, -86)
        })
    }
    
    
    // DELAY FUNCTION
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    // PAN GESTURE FUNCTION
    @IBAction func onPanMessage(gestureRecognizer: UIPanGestureRecognizer) {
        
        // PAN GESTURE VARS
        var location = panGest.locationInView(view)
        var translation = panGest.translationInView(view)
        var velocity = panGest.velocityInView(view)
        var messageSide = singleMessage.center.x + 160
        
        
        // BEGAN
        if panGest.state == UIGestureRecognizerState.Began {
            imageCenter = singleMessage.center
            laterIconCenter = laterIcon.center
            archiveIconCenter = laterIcon.center
            laterIcon.alpha = 0
            archiveIcon.alpha = 0
            deleteIcon.alpha = 0
            listIcon.alpha = 0
            
        // CHANGED
        } else if panGest.state == UIGestureRecognizerState.Changed {
            singleMessage.center.x = translation.x + imageCenter.x
            
            
            // 
            if (translation.x > -60) && (translation.x < 60) {
                self.messageView.backgroundColor = mailboxGray
                laterIcon.alpha = 0.3
                archiveIcon.alpha = 0.3
                
            } else if (translation.x > 60) && (translation.x < 260) {
                self.messageView.backgroundColor = mailboxGreen
                self.archiveIcon.center.x = singleMessage.frame.origin.x - 25
                self.deleteIcon.center.x = singleMessage.frame.origin.x - 25
                archiveIcon.alpha = 1
                laterIcon.alpha = 0
                deleteIcon.alpha = 0
                listIcon.alpha = 0
                
            } else if (translation.x < -60) && (translation.x > -260) {
                self.messageView.backgroundColor = mailboxYellow
                laterIcon.center.x = singleMessage.center.x + 185
                listIcon.center.x = singleMessage.center.x + 185
                laterIcon.alpha = 1
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
                listIcon.alpha = 0
                
            } else if (translation.x > 260) {
                self.messageView.backgroundColor = mailboxRed
                archiveIcon.center.x = singleMessage.frame.origin.x - 25
                deleteIcon.center.x = singleMessage.frame.origin.x - 25
                deleteIcon.alpha = 1
                laterIcon.alpha = 0
                archiveIcon.alpha = 0
                listIcon.alpha = 0

            } else if (translation.x < -260) {
                self.messageView.backgroundColor = mailboxBrown
                laterIcon.center.x = singleMessage.center.x + 185
                listIcon.center.x = singleMessage.center.x + 185
                listIcon.alpha = 1
                laterIcon.alpha = 0
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0

                self.buildScroll += 1
            }
        // ENDED
        } else if panGest.state == UIGestureRecognizerState.Ended {
            
            if (translation.x < 60) && (translation.x > -60) {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = self.singleMessage.frame.width/2
                })
            } else if (translation.x > 60) && (translation.x < 260) {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = self.singleMessage.frame.width + self.imageCenter.x + 80
                    self.archiveIcon.center.x = self.singleMessage.frame.width + self.imageCenter.x
                })
                delay(0.3, closure: { () -> () in
                    self.scrollAdjust()
                    self.delay(0.3, closure: { () -> () in
                        self.messageView.hidden = true
                    })
                })
            } else if (translation.x > 260) {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = self.singleMessage.frame.width + self.imageCenter.x + 80
                    self.deleteIcon.center.x = self.singleMessage.frame.width + self.imageCenter.x
                })
                delay(0.3, closure: { () -> () in
                    self.scrollAdjust()
                    self.delay(0.3, closure: { () -> () in
                        self.messageView.hidden = true
                    })
                })
            } else if (translation.x > -260) && (translation.x < -60) {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = self.imageCenter.x - self.singleMessage.frame.width - 80
                    self.laterIcon.center.x = self.singleMessage.center.x + 145
                    self.listIcon.center.x = self.singleMessage.center.x + 145
                    }, completion: { (finish) -> Void in
                        self.performSegueWithIdentifier("segueToReshedule", sender: self)
                        self.buildScroll += 1
                })
            } else if (translation.x < -260) {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = self.imageCenter.x - self.singleMessage.frame.width - 80
                    self.laterIcon.center.x = self.singleMessage.center.x + 135
                    self.listIcon.center.x = self.singleMessage.center.x + 135
                    }, completion: { (finish) -> Void in
                        self.performSegueWithIdentifier("segueToList", sender: self)
                        self.buildScroll += 1
                })
            }

            
        }
        
    }


}