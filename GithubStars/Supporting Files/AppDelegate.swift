//
//  AppDelegate.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/3/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit
import RxSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupApplicationCoordinator()
        
        return true
    }
    
    fileprivate func setupApplicationCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start()
    }
}

