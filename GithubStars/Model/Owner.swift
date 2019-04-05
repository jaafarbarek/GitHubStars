//
//  Owner.swift
//  GitHubStars
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import Foundation

struct Owner: Codable {
    var id : Int
    var avatarUrl : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
    }
}

extension Owner : Equatable {
    static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.id == rhs.id && lhs.avatarUrl == rhs.avatarUrl
    }
}
