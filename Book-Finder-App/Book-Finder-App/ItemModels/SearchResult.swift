//
//  SearchResult.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

struct SearchResult: Decodable {
    let kind: String?
    let totalItems: Int?
    let items: [BookInfo]?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case totalItems
        case items
    }
}
