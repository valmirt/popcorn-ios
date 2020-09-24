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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.tintColor = UIColor(named: "Main")
        
        return true
    }
}

