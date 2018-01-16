//
//  TrendingViewController.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var searchBar:UISearchBar!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        GithubDataProvider.shared.bindToTrending {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        //Code for demo purposes only
        searchBar.text = "Swift"
        self.searchBarSearchButtonClicked(searchBar)
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
    
    //MARK:- Search Bar operations
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else {
            return
        }
        GithubDataProvider.shared.updateTrending(onTerm: term)
    }
}

