//
//  HeadlinesResponse.swift
//  BuddleNews
//
//  Created by Hüsamettin Eyibil on 13.03.2022.
//

import Foundation

struct HeadlinesResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
