//
//  ViewController.swift
//  iOSAssesment
//
//  Created by Shangari on 28/05/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private var posts = [Post]()
    private var isFetching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchPosts()
    }

    private func fetchPosts() {
        guard !isFetching else { return }
        isFetching = true

        NetworkManager.shared.fetchPosts { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false

            switch result {
            case .success(let newPosts):
                self.posts.append(contentsOf: newPosts)
                self.tableView.reloadData()
            case .failure(let error):
                print("Error fetching posts: \(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.configure(with: posts[indexPath.row])
        
        let startTime = CFAbsoluteTimeGetCurrent()
        performHeavyComputation(for: cell)
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time for heavy computation: \(timeElapsed) seconds")
        
        return cell
    }

    func performHeavyComputation(for cell: PostTableViewCell) {
        for _ in 0..<10000 {
              _ = sqrt(12345.6789)
          }
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: selectedPost)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.post = sender as? Post
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            fetchPosts()
        }
    }

}



