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
    private let refreshControl = UIRefreshControl()
    private  let spinner = UIActivityIndicatorView(style: .gray) //spinner for loading data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    fileprivate func setUp() {
        configureRefreshControl()
        bindTrendingFeedElements()
        trendingFeedViewModel.downloadTrigger.onNext(())
    }
    // MARK: Configuration refresh control
    fileprivate func configureRefreshControl() {
        tableView.refreshControl = refreshControl
    }
    
    // MARK: Element bindings configuration
    fileprivate func bindTrendingFeedElements() {
        trendingFeedViewModel.repos
            .bind(to: tableView.rx.items(cellIdentifier: GitRepositoryTableViewCell.defaultReuseIdentifier)) { [unowned self] (row, repo: GitRepository, cell: GitRepositoryTableViewCell) in
                cell.configure(item: repo)
                
                if self.refreshControl.isRefreshing {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self.refreshControl.endRefreshing()
                    })
                }
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: trendingFeedViewModel.downloadTrigger)
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.subscribe(onNext: { [unowned self] (tuple: (cell: UITableViewCell, indexPath: IndexPath)) in
            
            if self.tableView.isIndexPath(tuple.indexPath, isInPreloadingDistance: 1) {
                // Load next page
                self.trendingFeedViewModel.downloadTrigger.onNext(())
                DispatchQueue.main.async {
                    self.startSpinnerAnimation()
                }
            }
        }).disposed(by: disposeBag)
        
        trendingFeedViewModel.repos.subscribe(onNext: { [unowned self] (repos: [GitRepository]) in
            // Scroll the table view a bit to reveal the next page
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                self.tableView.scroll(by: 10)
            })
        }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GitRepository.self).subscribe(onNext: { [unowned self] (repo: GitRepository) in
            self.repoSelectable?.didSelect(item: repo)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func startSpinnerAnimation (){
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    fileprivate func stopSpinnerAnimation(){
        spinner.stopAnimating()
        self.tableView.tableFooterView?.isHidden = true
    }
    
}

