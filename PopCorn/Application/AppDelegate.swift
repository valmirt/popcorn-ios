//
//  AppDelegate.swift
//  PopCorn
//
//  Created by Valmir Torres on 06/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator()
        window?.rootViewController = appCoordinator?.navigationController
        window?.makeKeyAndVisible()
        window?.tintColor = UIColor(named: "Main")
        appCoordinator?.start()
        
        return true
    }
}

