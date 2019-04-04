//
//  GitRepository.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/4/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import Foundation

struct GitRepository : Codable {
    
    var id : Int
    var commitsUrl : String
    var fullName : String
    var stargazersCount : Int
    var description : String
    var owner : Owner
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case commitsUrl = "commits_url"
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case description = "description"
        case owner = "owner"
    }
    
}

extension GitRepository {
    
    func readmeURL() -> URL {
        return URL(string: "https://github.com/" + fullName + "/blob/master/README.md")!
    }
    
    func ownerName() -> String {
        return fullName.components(separatedBy: "/").first!
    }
    
    func repoName() -> String {
        return fullName.components(separatedBy: "/").last!
    }
    
}


extension GitRepository : Equatable {
    static func == (lhs: GitRepository, rhs: GitRepository) -> Bool {
        return lhs.id == rhs.id && lhs.commitsUrl == rhs.commitsUrl && lhs.fullName == rhs.fullName && lhs.stargazersCount == rhs.stargazersCount && lhs.description == rhs.description && lhs.owner == rhs.owner
    }
}

extension GitRepository {
    init?(from json: [String: Any]) {
        guard
            let id = json["id"] as? Int,
            let description = json["description"] as? String,
            let stargazersCount = json["stargazers_count"] as? Int,
            let fullName = json["full_name"] as? String,
            let commitsUrl = json["commits_url"] as? String,
            let ownerId = (json["owner"] as! NSDictionary)["id"] as? Int,
            let ownerAvatarUrl = (json["owner"] as! NSDictionary)["avatar_url"] as? String
            else { return nil }
        
        self.init(id: id, commitsUrl: commitsUrl, fullName: fullName, stargazersCount: stargazersCount, description: description, owner: Owner(id: ownerId, avatarUrl: ownerAvatarUrl))
    }
}

