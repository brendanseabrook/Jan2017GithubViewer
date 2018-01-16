//
//  TrendingCell.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import UIKit

class TrendingCell : UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    weak var toPass:GithubRepoViewModel!
    
    static let reuse = "trendingCell"
    
    public func decorate(data:GithubRepoViewModel) {
        toPass = data
        name.text = data.name
        stars.text = data.starsLabel
        repoDescription.text = data.repoDescription
    }
}
