//
//  GitRepositoryTableViewCell.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import RxSwift

class GitRepositoryTableViewCell: UITableViewCell, Configurable, GitRepositoryPresentable {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    // MARK: - Configurable
    func configure(item: Any) {
        map(repo: item as? GitRepository)
    }
    
}
