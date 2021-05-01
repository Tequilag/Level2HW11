//
//  AppDelegate.swift
//  Level2HW11
//
//  Created by Andrey Buksha on 26.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SigningViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

