//
//  MockingGitAPIService.swift
//  GithubStarsTests
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import RxSwift
@testable import GithubStars
/**
 We can use this class for dependency injection of the API service in Unit tests
 */
class MockingGitAPIService : RepoService {
    
    var page: Int = 0
    
    var repos = [GitRepository]()
    
    func getMostPopularRepositories(byDate date: String) -> Observable<[GitRepository]> {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.path(forResource: "SampleResponseGITrepos", ofType: "json") else {
            return Observable<[GitRepository]>.just([])
        }
        return URLSession.shared.rx
            .json(url: URL(string: url)!)
            .flatMap { json throws -> Observable<[GitRepository]> in
                guard
                    let json = json as? [String: Any],
                    let itemsJSON = json["items"] as? [[String: Any]]
                    else {
                        return Observable.error(ServiceError.cannotParse)
                        
                }
                
                let repositories = itemsJSON.compactMap(GitRepository.init)
                return Observable.just(repositories)
        }
    }
    
}
