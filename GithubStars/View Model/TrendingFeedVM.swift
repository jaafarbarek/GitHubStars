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
                
                self.gitAPIService.page += 1
                
                DispatchQueue.global(qos: .background).async {
                    self.gitAPIService.getMostPopularRepositories(byDate: ">\(Date().getDateString(inThePastDays: 30))")
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

