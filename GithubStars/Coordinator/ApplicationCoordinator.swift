//
//  ApplicationCoordinator.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit
/// ApplicationCoordinator  that sets up our main coordinators as each of the two app tabs.
class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: MainTabBarController
    
    var gitRepoListCoordinator: GitRepoListCoordinator!
    var settings : SettingsCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = MainTabBarController()
        
    }
    
    func start() {
        let gitRepoListNav = UINavigationController()
        gitRepoListNav.navigationBar.prefersLargeTitles = true
        gitRepoListCoordinator = GitRepoListCoordinator(presenter: gitRepoListNav)
        gitRepoListCoordinator.start()
        
        let settingsNav = UINavigationController()
        settings = SettingsCoordinator(presenter: settingsNav)
        settings.start()
        
        rootViewController.viewControllers = [gitRepoListNav,settingsNav]
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
