//
//  Source.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import Foundation

struct Source: Codable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: Category?
    let language: String?
    let country: String?
}
