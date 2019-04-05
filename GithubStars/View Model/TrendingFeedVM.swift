//
//  TrendingFeedVM.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import RxSwift

class TrendingFeedVM {
    
    // MARK: Current api service
    let gitAPIService: RepoService
    
    // MARK: Rx Bindings & DisposeBag
    var disposeBag = DisposeBag()
    let downloadTrigger = PublishSubject<Void>()
    let repos = PublishSubject<[GitRepository]>()
    
    init(gitAPIService: RepoService) {
        self.gitAPIService = gitAPIService
        initRepos()
    }
   
    var allRepos = [GitRepository]()
    
    // MARK: Initialization subscription for [Repo]
    func initRepos() {
        downloadTrigger
            .subscribe(onNext: { [unowned self] in
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
                let dateString = formatter.string(from: date)
//  "https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc"
                //                let path = "search/repositories?q=created:&sort=stars&order=desc"
                let path = "search/repositories?q=created:>\(dateString)&sort=stars&order=desc"
                
                //                let urlString = self.gitAPIService.baseURL.absoluteString + "search/repositories?q=created:>\(dateString)"
                //                let urlString = self.gitAPIService.baseURL.absoluteString + "search/repositories?q=created:>\(dateString)&sort=stars&order=desc"//.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
                //                let urlString = self.gitAPIService.baseURL.absoluteString + "search/repositories?q=created:>\(dateString)&sort=stars&order=desc"
                self.gitAPIService.page += 1
                
                DispatchQueue.global(qos: .background).async {
                    self.gitAPIService.getRepos(path: path)
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { [unowned self] repos in
                            self.allRepos += repos
                            self.repos.onNext(self.allRepos)
                        })
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
    
}

