//
//  RepoSelectable.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import Foundation


protocol RepoSelectable : class, Selectable {
    func didSelect(item: GitRepository)
}

extension RepoSelectable {
    func didSelect(item: Any) {
        if let repo = item as? GitRepository {
            didSelect(item: repo)
        }
    }
}
