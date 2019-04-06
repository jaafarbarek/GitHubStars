//
//  RepoService.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//


import RxSwift

protocol RepoService: class {
    
    var page: Int { get set }
    
    // MARK: Get Repositories by URL
    func getMostPopularRepositories(byDate date: String) -> Observable<[GitRepository]>
    
}
