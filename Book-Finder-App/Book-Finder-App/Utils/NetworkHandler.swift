//
//  NetworkHandler.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Foundation

struct NetworkHandler {
    private let session = URLSession.shared
    private let baseURL = "https://www.googleapis.com/books/v1/volumes/"
    
    
    private func makeURL(api: APIable) -> URL? {
        var component = URLComponents(string: baseURL)
        
        component?.queryItems = api.params?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component?.url
    }
}
