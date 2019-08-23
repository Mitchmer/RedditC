//
//  PostListTableViewController.swift
//  RedditC
//
//  Created by Mitch Merrell on 8/21/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let cellID = "postCell"
    
    var posts = [MJMPost]()

    @IBOutlet weak var postSearchBar: UISearchBar!
    @IBOutlet weak var redditNavItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postSearchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = self.postSearchBar.text, !searchText.isEmpty else { return }
        
        postSearchBar.resignFirstResponder()
        let searchStr = searchText.replacingOccurrences(of: " ", with: "_")
        // Closures can capture strong reference cycles. A reference cycle that can't (the count can't decrement to 0) in order to properly deallocate
        MJMPostController.shared().searchForPosts(with: searchStr) { [weak self] (posts, error) in
            guard let self = self else { return }
            self.posts = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.postSearchBar.text = ""
                self.redditNavItem.title = "\(searchStr)"
            }
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostListTableViewCell

        let post = posts[indexPath.row]
        cell.post = post
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
