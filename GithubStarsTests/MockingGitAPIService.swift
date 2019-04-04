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
    
    func getRepos(path: String) -> Observable<[GitRepository]> {
        guard let url = Bundle.main.url(forResource: "SampleResponseGITrepos", withExtension: "json") else {
            return Observable<[GitRepository]>.just([])
        }
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { [unowned self] data in
                if let results = try? JSONDecoder().decode(GitRepositoriesResponse.self, from: data) {
                    self.repos = []
                    
                    results.items.forEach({ (repo : GitRepository) in
                        self.repos.append(repo)
                    })
                    
                    // Return result
                    return self.repos
                } else {
                    
                    // Return previous result
                    return self.repos
                }
            }
            .catchErrorJustReturn(self.repos)
    }
    
    
}
