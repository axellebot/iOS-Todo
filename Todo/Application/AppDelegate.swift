//
//  AppDelegate.swift
//  Todo
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        RootRouter().presentListsScreen(in: window!)
        return true
    }
}
