//
//  GithubRepoCell.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/18/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

extension Repo: ItemData {
    var ownerImageURL: URL? {
        let avatarURL = owner.avatarURL.replacingOccurrences(of: "?v=3", with: "")
        return URL(string: avatarURL)
    }
    var updatedFormatted: String {
        let df = Repo.dateFormatter
        df.dateStyle = .medium
        df.timeStyle = .short
        let date = df.string(from: updated)
        return date
    }
}

final class GithubRepoCell: TableCellBasic {
    
    // MARK: Outlets
    
    @IBOutlet weak var repoOwnerAvatar: UIImageView!
    
    @IBOutlet weak var repoOwnerName: UILabel!
    @IBOutlet weak var repoUpdateDate: UILabel!
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var stars: UILabel!
    
    // MARK: - TableCell
    
    override func customize() {
        repoOwnerAvatar.layer.cornerRadius = 32
        repoOwnerAvatar.layer.masksToBounds = true
    }
    
    override func update(with item: Item) {
        accessoryType = .disclosureIndicator
        
        if let repo = item.data as? Repo {
            if let url = repo.ownerImageURL {
                repoOwnerAvatar.loadImage(from: url)
            }
            repoOwnerName.text = "@\(repo.owner.username)"
            repoUpdateDate.text = repo.updatedFormatted
            repoName.text = repo.name
            repoDescription.text = repo.description
            forks.text = "⋔ \(repo.forksCount)"
            stars.text = "★ \(repo.starsCount)"
        }
    }
    
}
