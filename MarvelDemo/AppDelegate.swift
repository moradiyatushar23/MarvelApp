//
//  AppDelegate.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var appNavigationController: UINavigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navDashboard()
        return true
    }
    
    //MARK: - Navigation
    func navDashboard() {
        let VC = DashboardVC(nibName: "DashboardVC", bundle: nil)
        appNavigationController.viewControllers = [VC]
        self.window?.rootViewController = appNavigationController
        self.window?.makeKeyAndVisible()
    }
}

