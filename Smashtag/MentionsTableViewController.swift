//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Kevin Green on 6/22/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import Twitter

class MentionsTableViewController: UITableViewController
{
    private enum Mention {
        case media(Array<Twitter.MediaItem>)
        case mention(Array<Twitter.Mention>)
    }
    
    private var mentions: Array<(title: String, numMentions: Int, mentions: Mention)> = []
    
    var tweet: Twitter.Tweet? {
        didSet {
            mentions[0] = ("images", (tweet?.media.count)!, .media(tweet?.media ?? []))
            mentions[1] = ("hashtags", (tweet?.hashtags.count)!, .mention(tweet?.hashtags ?? []))
            mentions[2] = ("users", (tweet?.userMentions.count)!, .mention(tweet?.userMentions ?? []))
            mentions[3] = ("urls", (tweet?.urls.count)!, .mention(tweet?.urls ?? []))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mentions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mentions[section].numMentions
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Mention", for: indexPath)

        // Configure the cell...
        let mention = mentions[indexPath.section].mentions
        switch(mention) {
        case .media(let mediaItems):
            let mediaItem = mediaItems[indexPath.row]
            cell.textLabel?.text = "Image here"
        case .mention(let mentionItems):
            let mentionItem = mentionItems[indexPath.row]
            cell.textLabel?.text = mentionItem.keyword
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentions[section].title
    }

}
