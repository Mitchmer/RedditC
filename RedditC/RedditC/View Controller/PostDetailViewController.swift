//
//  PostDetailViewController.swift
//  RedditC
//
//  Created by Mitch Merrell on 8/22/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var upsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: MJMPost? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
