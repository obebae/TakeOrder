//
//  AppDelegate.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 12/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import IQKeyboardManager
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppDataMenager.shared.setup()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        let homeNaviViewController = HomeNavigationViewController.instantiate()
        let menuNaviViewController = UINavigationController(rootViewController: MenuTableViewController.instantiate())

        let slideMenuViewController = SlideMenuController(mainViewController: homeNaviViewController, leftMenuViewController: menuNaviViewController)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = slideMenuViewController
        
        return true
    }

}

