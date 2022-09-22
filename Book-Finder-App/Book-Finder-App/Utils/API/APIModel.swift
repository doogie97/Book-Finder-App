//
//  APIModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

protocol APIable {
    var host: String { get }
    var path: String { get }
    var params: [String: String]? { get }
    var method: HTTPMethod { get }
}

struct BookAPIModel: APIable {
    let bookTitle: String
    let host = "https://www.googleapis.com"
    let path = "/books/v1/volumes/"
    let startIndex: Int
    let maxResult: Int
    var params: [String: String]? {
        return ["q": bookTitle,
                "startIndex": String(startIndex),
                "maxResults": String(maxResult),
                "projection": "full"]
    }
    let method: HTTPMethod
}
