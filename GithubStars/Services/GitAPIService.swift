//
//  GitAPIService.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import RxSwift
import Kingfisher
import RxCocoa


// MARK: URLs
//let searchUrl = "https://api.github.com/search/repositories?q="
//let starsDescendingSegment = "&sort=stars&order=desc"
//let readmeSegment = "/blob/master/README.md"

var mainURL :String {
    let url = "https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc"
    let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    return urlEncoded!
}
class GitAPIService: RepoService {
    
    var page = 0
    
    private let baseURL = URL(string: "https://api.github.com/")!
    
    //    private func encodeParameters(params: [String: String]) -> String {
    //        let queryItems = params.map { URLQueryItem(name:$0, value:$1) }
    //        var components = URLComponents()
    //        components.queryItems = queryItems
    //        return components.percentEncodedQuery ?? ""
    //    }
    //    let url = URL(string: (baseURL.absoluteString + "search/repositories?q='created:>\(dateString)'&sort=stars&order=desc&page=\(page)"))!
    
    private var repos = [GitRepository]()
    
    func getRepos(path: String) -> Observable<[GitRepository]> {
        var currentUrlString = baseURL.absoluteString + path
//        if page != 0 {
//            currentUrlString += "&page=\(page)"
//        }
        let urlEncoded = currentUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlEncoded) else { return Observable<[GitRepository]>.just([]) }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { [unowned self] data in
                if let results = try? JSONDecoder().decode(GitRepositoriesResponse.self, from: data) {
                    var urls = [URL]()
                    self.repos = []
                    
                    results.items.forEach({ (repo : GitRepository) in
                        urls.append(URL(string: repo.owner.avatarUrl)!)
                        self.repos.append(repo)
                    })
                    
                    // Prefetch all images to memory
                    ImagePrefetcher(urls: urls).start()
                    
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

