//
//  APIModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

protocol APIable {
    var bookTitle: String { get }
    var params: [String: String]? { get }
    var method: HTTPMethod { get }
}

struct APIModel: APIable {
    let bookTitle: String
    let startIndex: Int
    let maxResult: Int
    var params: [String: String]? {
        return ["q": bookTitle,
                "startIndex": String(startIndex),
                "maxResults": String(maxResult),
                "projection": "lite"]
    }
    let method: HTTPMethod
}
