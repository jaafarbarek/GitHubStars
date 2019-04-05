//
//  GitRepositoryPresentable.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import RxSwift
import Kingfisher

protocol GitRepositoryPresentable {
    
    var repoNameLabel: UILabel! {set get}
    var repoDescriptionLabel: UILabel! {set get}
    var avatarImageView: UIImageView! {set get}
    var ownerNameLabel: UILabel! {set get}
    var starCountLabel: UILabel! {set get}
    var disposeBag : DisposeBag {set get}
}

extension GitRepositoryPresentable {
    func map(repo: GitRepository?) {
        guard let repo = repo else {
            return
        }
        
        repoNameLabel?.text = repo.repoName()
        repoDescriptionLabel?.text = repo.description
        avatarImageView?.kf.setImage(with: URL(string: repo.owner.avatarUrl)!)
        ownerNameLabel?.text = repo.ownerName()
        starCountLabel?.text = formatCount(repo.stargazersCount)
    }
    
    
    func formatCount(_ number: Int) -> String? {
        if number > 1000 {
            let num: Float = Float(number) / 1000.0
            let str = String(format: "%.1f", arguments: [num])
            return "\(str)k"
        } else if number > 1000000 {
            let num: Float = Float(number) / 10000.0
            let str = String(format: "%.1f", arguments: [num])
            return "\(str)M"
        }
        return "\(number)"
    }
    
}
