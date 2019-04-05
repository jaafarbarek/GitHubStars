//
//  GitRepoListViewController.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//


import RxSwift

class GitRepoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var trendingFeedViewModel: TrendingFeedVM!
    var disposeBag = DisposeBag()
    
    weak var repoSelectable : RepoSelectable?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
}

