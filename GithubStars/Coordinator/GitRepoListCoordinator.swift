//
//  GitRepoListCoordinator.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit

class GitRepoListCoordinator: Coordinator {
    
  
    private let presenter: UINavigationController
    private var gitRepoListViewController: GitRepoListViewController?
    private var gitRepoDetailCoordinator: GitRepoDetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let vc = GitRepoListViewController.instantiate()
        vc.repoSelectable = self
        vc.navigationItem.title = "Trending Repos"
        vc.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(named: "icon-trending"), tag: 0)
        presenter.pushViewController(vc, animated: true)
        gitRepoListViewController = vc
        
    }
}

extension GitRepoListCoordinator: RepoSelectable {
    
    func didSelect(item: GitRepository) {
        let coordinator = GitRepoDetailCoordinator(presenter: presenter, repo: item)
        coordinator.start()
        gitRepoDetailCoordinator = coordinator
    }
}
