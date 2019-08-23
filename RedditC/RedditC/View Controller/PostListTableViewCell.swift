//
//  PostListTableViewCell.swift
//  RedditC
//
//  Created by Mitch Merrell on 8/22/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class PostListTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var post: MJMPost? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let postToSend = post else { return }
        switch postToSend.image{
        case "default":
            DispatchQueue.main.async {
                self.postImageView.image = UIImage(named: "default.jpeg")
            }
        case "self":
            DispatchQueue.main.async {
                self.postImageView.image = UIImage(named: "default.jpeg")
            }
        default:
            MJMPostController.shared().fetchImage(for: postToSend) { (image) in
                print(image)
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        }
        self.titleLabel.text = postToSend.title
        self.upsLabel.text = "\(postToSend.ups ?? 0) upvotes 👍"
        self.commentsLabel.text = "\(postToSend.commentCount ?? 0) comments 💬"
        
    }
    
}
