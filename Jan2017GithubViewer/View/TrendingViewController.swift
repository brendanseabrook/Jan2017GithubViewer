//
//  TrendingViewController.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        GithubDataProvider.shared.bindToTrending {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        GithubDataProvider.shared.updateTrending()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            (segue.destination as? DetailsViewController)?.viewModel = (sender as! TrendingCell).toPass
        }
    }
    
    //MARK:- Table view operations
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GithubDataProvider.shared.trending.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reuse) as! TrendingCell
        
        cell.decorate(data: GithubDataProvider.shared.trending[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

