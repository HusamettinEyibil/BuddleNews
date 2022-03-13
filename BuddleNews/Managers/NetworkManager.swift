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
    
    private func createRequest(forPath path: String, withSource source: String? = nil, type: HTTPMethod = .GET, completion: @escaping (URLRequest) -> Void) {
        guard var urlComponent = URLComponents(string: baseURL + path) else {
            return
        }
        urlComponent.queryItems = [
            URLQueryItem(name: "sources", value: source)
        ]
        if let url = urlComponent.url {
            var request = URLRequest(url: url)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            
            request.setValue("*/*", forHTTPHeaderField: "Accept")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue(Credentials.apiKey, forHTTPHeaderField: "x-api-key")
            
            completion(request)
        }
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
    
    public func getHeadlines(withSource source: String, completion: @escaping (Result<HeadlinesResponse, NetworkError>) -> Void) {
        createRequest(forPath: headlinesEndpoint, withSource: source) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(HeadlinesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print("Error")
                    completion(.failure(.failedToParseObject))
                }
            }
            task.resume()
        }
    }
}
