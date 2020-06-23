//
//  AppDelegate.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,
                                        height: UIScreen.main.bounds.size.height))
        Coordinator.shared.initializeApp()
        window?.backgroundColor = .clear
        window?.makeKeyAndVisible()
        return true
    }
}

