//
//  SourcesViewModel.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 12.03.2022.
//

import Foundation

struct SourcesViewModel {
    let id: String
    let name: String
    let description: String
    let category: Category
    
    public static func getFilteredSources(completion: @escaping ([SourcesViewModel]?, Error?) -> Void) {
        NetworkManager.shared.getSources { result in
            switch result {
            case .success(let response):
                if let sources = response.sources {
                    let filtered : [SourcesViewModel] = sources.filter({ source in
                        source.language == "en"
                    }).map { SourcesViewModel(id: $0.id ?? "",
                                              name: $0.name ?? "",
                                              description: $0.description ?? "",
                                              category: $0.category ?? .general)
                    }
                    completion(filtered, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
