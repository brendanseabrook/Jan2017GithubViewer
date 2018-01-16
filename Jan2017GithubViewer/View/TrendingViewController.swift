//
//  TrendingViewController.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var observation:NSKeyValueObservation?
    @IBOutlet var tableView:UITableView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        observation = GithubDataProvider.shared.observe(\.trending) {[weak self] ( vm, change) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GithubDataProvider.shared.updateTrending()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Table view operations
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GithubDataProvider.shared.trending.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reuse) as! TrendingCell
        cell.name.text = GithubDataProvider.shared.trending[indexPath.row].name
        return cell
    }
}

