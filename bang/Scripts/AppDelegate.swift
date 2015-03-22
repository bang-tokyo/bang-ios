//
//  AppDelegate.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var facebookManager = FacebookManager.sharedInstance
    var peripheralManager = BLEPeripheralManager.sharedInstance
    var locationManager = LocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        // Logs 'install' and 'app activate' App Events.
        FBAppEvents.activateApp()

        facebookManager.delegate = self
        moveToProperViewControllerByLoginState(facebookManager.openFacebookSessionIfStateCreatedTokenLoaded())

        // TODO : - BLEが有効かどうか判定有効でなければViewをかぶせるように修正
        // TODO : - CoreLocationが有効でなければViewをかぶせるように修正

        locationManager.setUpSignificantChangeUpdates()
        locationManager.delegate = self
        if LocationManager.canUseLocationService() {
            locationManager.startLocationUpdates()
        }

        return true
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

        // Handle the user leaving the app while the Facebook login dialog is being shown
        FBAppCall.handleDidBecomeActive()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        //println("---> \(url)")
        return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
    }

}

// MARK: - FacebookManagerDelegate
extension AppDelegate: FacebookManagerDelegate {
    func handlerFacebookSessionStateChanged(isLogined: Bool) {
        moveToProperViewControllerByLoginState(isLogined)
    }
}

// MARK: - LocationManagerDelegate
extension AppDelegate: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
        // TODO: - APIでユーザーのローケーションを更新
        Tracker.sharedInstance.debug("didUpdateLocation: \(location.coordinate.latitude) \(location.coordinate.longitude)")
    }
}

// MARK: - Private functions
extension AppDelegate {
    private func moveToProperViewControllerByLoginState(isLogined: Bool) {
        if isLogined {
            var profileViewController = ProfileViewController.build()
            self.showViewController(profileViewController)
        } else {
            var loginViewController = LoginViewController.build()
            self.showViewController(loginViewController)
        }
    }

    private func showViewController(viewController: UIViewController) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = viewController;
        self.window!.makeKeyAndVisible()
    }
}

