//
//  HomeController.swift
//  Versettos
//
//  Created by Christian Soler & Eduardo Matos  on 9/25/15.
//  Copyright © 2015 Christian Soler & Eduardo Matos. All rights reserved.
//

import UIKit
import Parse
import Social

class HomeController: UIViewController, UIDocumentInteractionControllerDelegate
{
    @IBOutlet weak var verseContentLabel: UILabel!
    @IBOutlet weak var verseLocationLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var brandLabel: UILabel!

    @IBOutlet weak var twitterConstraintRight: NSLayoutConstraint!
    @IBOutlet weak var facebookConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var instagramConstraintLeft: NSLayoutConstraint!
    @IBOutlet var screenTapGesture: UITapGestureRecognizer!
    
    var documentController:UIDocumentInteractionController!
    var versiculos = [PFObject]()
    let colors = Colors()
    var timer = NSTimer()
    var isTimerModeActived = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.verseContentLabel.alpha = 0
        self.verseLocationLabel.alpha = 0
        
        self.screenTapGesture = UITapGestureRecognizer(target: self, action:Selector("onTapGesture:"))
        view.addGestureRecognizer(self.screenTapGesture)
        
        let parse = ParseHandler();
        parse.getVersiculosFromParse { (result) -> Void in
            self.versiculos = result;
            self.displayContent(self.getRandomVerse())
            self.fadeIn()
        }
    }
    
    private func displayContent(data: PFObject){
        self.verseContentLabel.text = data["content"] as? String
        self.verseLocationLabel.text = data["location"] as? String
        self.fadeIn()
        
    }
    
    private func getRandomVerse() -> PFObject! {
        return versiculos[Int(arc4random_uniform(UInt32(versiculos.count)))]
    }
    
    private func activateTimerMode(){
        
        UIView.animateWithDuration(0.5, animations: {
            self.instagramConstraintLeft.constant += self.view.bounds.width
            self.twitterConstraintRight.constant -= self.view.bounds.width
            self.facebookConstraintBottom.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        })
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("fadeOut"), userInfo: nil, repeats: true)
        self.timerButton.setTitle("Stop", forState: .Normal)
        self.isTimerModeActived = true
    }
    
    private func deactivateTimerMode(){
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8, options: [], animations: {
                self.instagramConstraintLeft.constant = 0
                self.twitterConstraintRight.constant = 0
                self.facebookConstraintBottom.constant = 20
                self.view.layoutIfNeeded()
            }, completion: nil)
        
        self.timer.invalidate()
        self.timerButton.setTitle("Play", forState: .Normal)
        self.isTimerModeActived = false
    }
    
    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {
        self.fadeOut()
    }
    
    @IBAction func timerModeHandler() {
        if isTimerModeActived {
            self.deactivateTimerMode()
        } else {
            self.activateTimerMode()
        }
    }
    
    @IBAction func shareToInstagram() {
        let instagramUrl = NSURL(string: "instagram://app")
        
        if UIApplication.sharedApplication().canOpenURL(instagramUrl!) {
            let imageData = UIImageJPEGRepresentation(getScreenImage(), 1.0)
            let writePath = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("instagram.igo")
            
            if !imageData!.writeToFile(writePath, atomically: true) {
                return;
            } else {
                let fileURL = NSURL(fileURLWithPath: writePath)
                
                self.documentController = UIDocumentInteractionController(URL: fileURL)
                self.documentController.delegate = self
                self.documentController.UTI = "com.instagram.exclusivegram"
                self.documentController.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
            }
        } else {
            print("App not available")
            self.displayError("Please login to a Instagram account to share.")
        }
    }
    
    @IBAction func shareToTwitter(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let compose:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            compose.setInitialText("Shared via Versettos")
            compose.addImage(self.getScreenImage())
            self.presentViewController(compose, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareToFacebook(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let compose:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            compose.setInitialText("Shared via Versettos")
            compose.addImage(self.getScreenImage())
            self.presentViewController(compose, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func getScreenImage() -> UIImage {
        self.brandLabel.alpha = 1
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.bounds.width, view.bounds.height - 140.0), false, 0.0)
        
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        view.drawViewHierarchyInRect(CGRectMake(0, -70, view.bounds.width, view.bounds.height), afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.brandLabel.alpha = 0
        
        return image
    }
    
    private func displayError(error: String){
        let alertController = UIAlertController(title: "Versetto", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func fadeIn(){
        UIView.animateWithDuration(0.3,
            animations: {
                self.verseContentLabel.alpha = 1
                self.verseLocationLabel.alpha = 1
            }, completion: nil)
    }
    
    func fadeOut(){
        UIView.animateWithDuration(0.3, animations: {
                self.verseContentLabel.alpha = 0
                self.verseLocationLabel.alpha = 0
                self.view.backgroundColor = self.colors.randomColor()
            
            }, completion: { finished in
                self.displayContent(self.getRandomVerse())
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            self.fadeOut()
        }
    }
}
