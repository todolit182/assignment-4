//
//  SearchTableViewController.swift
//  Smashtag
//
//  Created by Kevin Green on 6/23/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var searchList: RecentTweets? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "Search History"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchList = RecentTweets()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchList!.stack.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search string", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = searchList!.stack[indexPath.row]

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recent searches to results" {
            if let tweetTVC = segue.destination as? TweetTableViewController {
                if let senderCell = sender as? UITableViewCell {
                    tweetTVC.searchText = senderCell.textLabel?.text
                }
            }
        }
    }


}
