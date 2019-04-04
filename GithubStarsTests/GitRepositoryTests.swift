//
//  GitRepositoryTests.swift
//  GithubStarsTests
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

@testable import GithubStars
import XCTest

class GitRepositoryTests :XCTestCase {
    
    private let sampleJSON: [String: Any] = [
        "id": 127754768,
        "full_name": "kentcdodds/advanced-react-patterns-v2",
        "commits_url": "https://api.github.com/repos/kentcdodds/advanced-react-patterns-v2/commits{/sha}",
        "stargazers_count": 1111,
        "description": "Created with CodeSandbox",
        "owner": [
            "id":1500684,
            "avatar_url":"https://avatars0.githubusercontent.com/u/1500684?v=4"
        ]
    ]
    
    private let testRepository1 = GitRepository(id: 127754768, commitsUrl: "https://api.github.com/repos/kentcdodds/advanced-react-patterns-v2/commits{/sha}", fullName: "kentcdodds/advanced-react-patterns-v2", stargazersCount: 1111, description: "Example Firefox add-ons created using the WebExtensions API", owner: Owner(id: 1500684, avatarUrl: "https://avatars0.githubusercontent.com/u/1500684?v=4"))
    
    private let testRepository2 = GitRepository(id: 127754768, commitsUrl: "https://api.github.com/repos/kentcdodds/advanced-react-patterns-v2/commits{/sha}", fullName: "kentcdodds/advanced-react-patterns-v2", stargazersCount: 1111, description: "Example Firefox add-ons created using the WebExtensions API", owner: Owner(id: 1500684, avatarUrl: "https://avatars0.githubusercontent.com/u/1500684?v=4"))
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testReadmeURL(){
        
        let url = testRepository1.readmeURL()
        let url2 = URL(string:"https://github.com/kentcdodds/advanced-react-patterns-v2/blob/master/README.md")!
        
        XCTAssertEqual(url, url2)
    }
    func testOwnerName(){
        
        let owner1 = testRepository1.ownerName()
        let owner2 = "kentcdodds/advanced-react-patterns-v2".components(separatedBy: "/").first!
        
        XCTAssertEqual(owner1, owner2)
    }
    func testRepoName(){
        
        let owner1 = testRepository1.repoName()
        let owner2 = "kentcdodds/advanced-react-patterns-v2".components(separatedBy: "/").last!
        
        XCTAssertEqual(owner1, owner2)
    }
    
    func test_InitFromJSON_AllFieldsAreCorrect() {
        guard let repository = GitRepository(from: sampleJSON) else {
            return XCTFail()
        }
        
        XCTAssertEqual(repository.id, 127754768)
        XCTAssertEqual(repository.fullName, "kentcdodds/advanced-react-patterns-v2")
        XCTAssertEqual(repository.commitsUrl, "https://api.github.com/repos/kentcdodds/advanced-react-patterns-v2/commits{/sha}")
        XCTAssertEqual(repository.stargazersCount, 1111)
        XCTAssertEqual(repository.description, "Created with CodeSandbox")
        XCTAssertEqual(repository.owner, Owner(id: 1500684, avatarUrl: "https://avatars0.githubusercontent.com/u/1500684?v=4"))
        
    }
    
    func test_EqualityForEqualRepositories_ReturnsTrue() {
        
        XCTAssertEqual(testRepository1, testRepository2)
    }
}
