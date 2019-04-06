//
//  GithubService.swift
//  RepoSearcher
//
//  Created by Arthur Myronenko on 6/29/17.
//  Copyright © 2017 UPTech Team. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ServiceError: Error {
    case cannotParse
}

/// A service that knows how to perform requests for GitHub data.
class GithubService:RepoService {
    
    var page = 0
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /// - Parameter language: Language to filter by
    /// - Returns: A list of most popular repositories filtered by langugage
    func getMostPopularRepositories(byDate date: String) -> Observable<[GitRepository]> {
        let encodedDate = date.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var urlString = "https://api.github.com/search/repositories?q=created:\(encodedDate)&sort=stars&order=desc"
        if page != 0 {
            urlString += "&page=\(page)"
        }
        let url = URL(string:urlString )!
        
        return session.rx
            .json(url: url)
            .flatMap { json throws -> Observable<[GitRepository]> in
                guard
                    let json = json as? [String: Any],
                    let itemsJSON = json["items"] as? [[String: Any]]
                    else { return Observable.error(ServiceError.cannotParse) }
                
                let repositories = itemsJSON.compactMap(GitRepository.init)
                return Observable.just(repositories)
        }
    }
    
    
}
