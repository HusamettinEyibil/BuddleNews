//
//  HeadlinesViewModel.swift
//  BuddleNews
//
//  Created by Hüsamettin Eyibil on 13.03.2022.
//

import Foundation

struct HeadlinesViewModel {
    let title: String
    let imageURL: String
    let articleDate: String
    
    public static func getArticles(withSource source: String, completion: @escaping ([HeadlinesViewModel]?, Error?) -> Void) {
        NetworkManager.shared.getHeadlines(withSource: source) { result in
            switch result {
            case .success(let response):
                if let articles = response.articles {
                    let filtered : [HeadlinesViewModel] = articles.map { article in
                        HeadlinesViewModel(title: article.title,
                                           imageURL: article.urlToImage ?? "",
                                           articleDate: article.publishedAt ?? "")
                    }
                    completion(filtered, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
