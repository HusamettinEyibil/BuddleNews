//
//  Article.swift
//  BuddleNews
//
//  Created by Hüsamettin Eyibil on 13.03.2022.
//

import Foundation

class Article: Codable {

    let source: Source?
    let author: String?
    let title: String!
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
