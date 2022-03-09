//
//  NetworkManager.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://newsapi.org/v2/"
    
    private let sourcesEndpoint = "sources/"
    private let headlinesEndpoint = "top-headlines"
    
    private init() {}
    
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(forPath path: String, type: HTTPMethod = .GET, completion: @escaping (URLRequest) -> Void) {
        guard let url = URL(string: baseURL + path) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(API_KEY, forHTTPHeaderField: "x-api-key")
        
        completion(request)
    }
    
    // MARK: - Public
    
    public func getSources(completion: @escaping (Result<SourcesResponse, NetworkError>) -> Void) {
        createRequest(forPath: sourcesEndpoint) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SourcesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToParseObject))
                }
            }
            task.resume()
        }
    }
    
    public func getHeadlines(completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}
