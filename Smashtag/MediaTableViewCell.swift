//
//  MediaTableViewCell.swift
//  Smashtag
//
//  Created by Kevin Green on 6/23/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import Twitter

class MediaTableViewCell: UITableViewCell
{

    @IBOutlet weak var mediaImage: UIImageView!
    
    var media: Twitter.MediaItem? { didSet { updateUI() } }
    
    // whenever our public API tweet is set
    // we just update our outlets using this method
    private func updateUI() {
        
        if let mediaURL = media?.url {
            // FIXME: blocks main thread
            if let imageData = try? Data(contentsOf: mediaURL) {
                mediaImage?.image = UIImage(data: imageData)
            }
        } else {
            mediaImage?.image = nil
        }
    }

}
