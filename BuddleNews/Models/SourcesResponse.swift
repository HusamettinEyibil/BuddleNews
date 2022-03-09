//
//  SourcesResponse.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import Foundation

struct SourcesResponse: Codable {
    let status: String?
    let sources: [Source]?
    let code: String?
    let message: String?
}
