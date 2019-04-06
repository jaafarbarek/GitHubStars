//
//  GitRepoListViewControllerTests.swift
//  GithubStarsTests
//
//  Created by Jaafar Barek on 4/6/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import XCTest
@testable import GithubStars

class GitRepoListViewControllerTests: XCTestCase {
    var vc : GitRepoListViewController!
    override func setUp() {
        super.setUp()
        vc = GitRepoListViewController.instantiate()
        let githubService = GithubService()
        let trendingFeedViewModel = TrendingFeedVM(githubService: githubService)
        vc.trendingFeedViewModel = trendingFeedViewModel
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeallocation() {
        assertDeallocation { () -> UIViewController in
            
            return vc
        }
    }
    
}
extension XCTestCase {
    
    /// Verifies whether the given constructed UIViewController gets deallocated after being presented and dismissed.
    ///
    /// - Parameter testingViewController: The view controller constructor to use for creating the view controller.
    func assertDeallocation(of testedViewController: () -> UIViewController) {
        weak var weakReferenceViewController: UIViewController?
        
        let autoreleasepoolExpectation = expectation(description: "Autoreleasepool should drain")
        autoreleasepool {
            let rootViewController = UIViewController()
            
            // Make sure that the view is active and we can use it for presenting views.
            let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
            
            /// Present and dismiss the view after which the view controller should be released.
            rootViewController.present(testedViewController(), animated: false, completion: {
                weakReferenceViewController = rootViewController.presentedViewController
                XCTAssertNotNil(weakReferenceViewController)
                
                rootViewController.dismiss(animated: false, completion: {
                    autoreleasepoolExpectation.fulfill()
                })
            })
        }
        wait(for: [autoreleasepoolExpectation], timeout: 10.0)
        wait(for: weakReferenceViewController == nil, timeout: 3.0, description: "The view controller should be deallocated since no strong reference points to it.")
    }
    
    /// Checks for the callback to be the expected value within the given timeout.
    ///
    /// - Parameters:
    ///   - condition: The condition to check for.
    ///   - timeout: The timeout in which the callback should return true.
    ///   - description: A string to display in the test log for this expectation, to help diagnose failures.
    func wait(for condition: @autoclosure @escaping () -> Bool, timeout: TimeInterval, description: String, file: StaticString = #file, line: UInt = #line) {
        let end = Date().addingTimeInterval(timeout)
        
        var value: Bool = false
        let closure: () -> Void = {
            value = condition()
        }
        
        while !value && 0 < end.timeIntervalSinceNow {
            if RunLoop.current.run(mode: RunLoop.Mode.default, before: Date(timeIntervalSinceNow: 0.002)) {
                Thread.sleep(forTimeInterval: 0.002)
            }
            closure()
        }
        
        closure()
        
        XCTAssertTrue(value, "➡️🚨 Timed out waiting for condition to be true: \"\(description)\"", file: file, line: line)
    }
}
