//
//  GitRepoDetailCoordinator.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//


import UIKit
import SafariServices

class GitRepoDetailCoordinator: Coordinator {
    private let presenter: UIViewController
    private let repo: GitRepository
    private var safariViewController: SFSafariViewController?
    
    init(presenter: UIViewController, repo: GitRepository) {
        self.presenter = presenter
        self.repo = repo
    }
    

    
    func start() {
        safariViewController = presenter.showSafariVC(url: repo.readmeURL())
    }
}
