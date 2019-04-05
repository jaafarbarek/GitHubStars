//
//  SettingsCoordinator.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit

class SettingsCoordinator:  Coordinator {
    
    
    private let presenter: UINavigationController
    private var settingsViewController: SettingsViewController?
    
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let vc = SettingsViewController.instantiate()
        
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "icon-settings"), tag: 1)
        presenter.pushViewController(vc, animated: true)
        settingsViewController = vc
        
    }
}

