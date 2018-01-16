//
//  DetailsViewController.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import UIKit

class DetailsViewController : UIViewController {
    var viewModel:GithubRepoViewModel!
    
    @IBOutlet var profileImage:UIImageView!
    @IBOutlet var username:UILabel!
    @IBOutlet var repoDescription:UITextView!
    @IBOutlet var readme:UITextView!
    @IBOutlet var segment:UISegmentedControl!
    
    override func viewDidLoad() {
        
        self.title = viewModel.name
        
        self.username.text = viewModel.ownersName
        self.repoDescription.text = viewModel.repoDescription
        
        //This is hacky but apple should really let you set it in interface builder
        segment.backgroundColor = UIColor.white
        
        segment.setTitle(viewModel.starsLabel, forSegmentAt: 0)
        segment.setTitle(viewModel.forksLabel, forSegmentAt: 1)
        
        viewModel.bindToImage {
            DispatchQueue.main.async {
                self.profileImage.image = self.viewModel.portraitInCircle
            }
        }
        
        viewModel.bindToReadme {
            DispatchQueue.main.async {
                self.readme.text = self.viewModel.readme
            }
        }
        
        GithubDataProvider.shared.updateRepo(repo: viewModel)
    }
}
