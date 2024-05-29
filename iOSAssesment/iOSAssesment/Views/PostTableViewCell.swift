//
//  PostTableViewCell.swift
//  iOSAssesment
//
//  Created by Shangari on 28/05/24.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    func configure(with post: Post) {
        titleLabel.text = post.title
        idLabel.text = String(post.id)
        // Perform heavy computation
//        let computedValue = heavyComputation(for: post)
//        computedLabel.text = "Computed: \(computedValue)"
    }

    private func heavyComputation(for post: Post) -> String {
        let startTime = CFAbsoluteTimeGetCurrent()
        // Simulate heavy computation
        let result = "\(post.title.count * post.id)"
        let endTime = CFAbsoluteTimeGetCurrent()
        print("Heavy computation time: \(endTime - startTime) seconds")
        return result
    }
}
