//
//  NetworkManager.swift
//  iOSAssesment
//
//  Created by Shangari on 28/05/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    private var currentPage = 1
    private let pageSize = 10

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = URL(string: "\(baseURL)?_page=\(currentPage)&_limit=\(pageSize)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else { return }

            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.currentPage += 1
                    completion(.success(posts))
                }
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

