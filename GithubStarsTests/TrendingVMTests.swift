//
//  TrendingVMTests.swift
//  GithubStarsTests
//
//  Created by Jaafar Barek on 4/6/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import Foundation
@testable import GithubStars
import XCTest
//import RxTest
import RxSwift

class TrendingFeedVMTests: XCTestCase {
    
    
    
//    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var githubService: MockingGitAPIService!
    var viewModel: TrendingFeedVM!
    let repos = PublishSubject<[GitRepository]>()
    var allRepos = [GitRepository]()
    
    override func setUp() {
        super.setUp()
        
        //testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        githubService = MockingGitAPIService()
        viewModel = TrendingFeedVM(githubService: githubService)
    }
    let queue = DispatchQueue(label: "SerialQueue", qos: .background)
    func test_Repositories_ReturnsValidViewModels() {
        let testRepository = GitRepository(id: 127754768, commitsUrl: "https://api.github.com/repos/kentcdodds/advanced-react-patterns-v2/commits{/sha}", fullName: "kentcdodds/advanced-react-patterns-v2", stargazersCount: 1111, description: "Example Firefox add-ons created using the WebExtensions API", owner: Owner(id: 1500684, avatarUrl: "https://avatars0.githubusercontent.com/u/1500684?v=4"))
        
        queue.async {
            self.githubService.getMostPopularRepositories(byDate: ">\(Date().getDateString(inThePastDays: 30))")
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [unowned self] repos in
                    self.allRepos += repos
                    self.repos.onNext(self.allRepos)
                   
                })
                .disposed(by: self.disposeBag)
        }
//        guard let firstRepo = self.allRepos.first else {
//            return XCTFail()
//        }
//        
//        XCTAssertEqual(testRepository, firstRepo)
       
    }

}
