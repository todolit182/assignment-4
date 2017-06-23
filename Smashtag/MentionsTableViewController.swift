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
    
    private var mentions: Array<(title: String, numMentions: Int, mentions: Mention)> = [("", 0, Mention.mention([])),
                                                                                         ("", 0, Mention.mention([])),
                                                                                         ("", 0, Mention.mention([])),
                                                                                         ("", 0, Mention.mention([]))
                                                                                        ]
    var tweet: Twitter.Tweet? {
        didSet {
            updateModel()
        }
    }
    
    private func updateModel() {
        if tweet != nil {
            if tweet!.media.count > 0 {
                mentions[0] = ("images", tweet!.media.count, .media(tweet!.media))
            }
            if tweet!.hashtags.count > 0 {
                mentions[1] = ("hashtags", tweet!.hashtags.count, .mention(tweet!.hashtags))
            }
            if tweet!.userMentions.count > 0 {
                mentions[2] = ("users", tweet!.userMentions.count, .mention(tweet!.userMentions))
            }
            if tweet!.urls.count > 0 {
                mentions[3] = ("urls", tweet!.urls.count, .mention(tweet!.urls))
            }
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
        var cell: UITableViewCell

        // Configure the cell...
        let mention = mentions[indexPath.section].mentions
        switch(mention) {
        case .media(let mediaItems):
            let mediaItem = mediaItems[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "Media", for: indexPath)
            if let mediaCell = cell as? MediaTableViewCell {
                mediaCell.media = mediaItem
            }
        case .mention(let mentionItems):
            let mentionItem = mentionItems[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "Mention", for: indexPath)
            cell.textLabel?.text = mentionItem.keyword
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let mention = mentions[indexPath.section].mentions
        switch(mention) {
        case .media(let mediaItems):
            let mediaItem = mediaItems[indexPath.row]
            let aspectRatio = mediaItem.aspectRatio
            let cell = tableView.dequeueReusableCell(withIdentifier: "Media", for: indexPath)
            let height = CGFloat(cell. * aspectRatio)
            return height
        case .mention:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentions[section].title
    }

}
