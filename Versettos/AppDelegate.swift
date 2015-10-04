//
//  AppDelegate.swift
//  Versettos
//
//  Created by Christian Soler & Eduardo Matos  on 9/25/15.
//  Copyright © 2015 Christian Soler & Eduardo Matos. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var selectedShortcut: String?
    var shortcutItem: UIApplicationShortcutItem?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("eVROJ73fLbqPjUNNnj2DZQ3NueUbEecETY8yVxz7",
            clientKey: "bqe9Sv7ibKlAiBlICuTdQ1uIY1e0CEt6bYnltJcF")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        return performShortcutDelegate
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        completionHandler(quickActionHandler(shortcutItem))
    }
    
    func quickActionHandler(shortcutItem:UIApplicationShortcutItem) -> Bool {
        var success = false
        print("At Delegate Handler")
        
        switch (shortcutItem.type){
            case "com.nubeink.versettos.share.quickaction":
                self.shortcutItem = shortcutItem
                success = true
                break
            default:
                self.shortcutItem = nil
                success = false
                break
        }
        
        // Get the view controller you want to load
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainSB.instantiateViewControllerWithIdentifier("HomeControllerSBID") as! HomeController
        
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
        
        return success
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        guard let shortcut = shortcutItem else { return }
        
        quickActionHandler(shortcut)
        
        self.shortcutItem = nil
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

