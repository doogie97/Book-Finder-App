//
//  NetworkManger.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Foundation

protocol NetworkMangerable {
    func newRequest(api: APIable) async throws -> Data
}

struct NetworkManger: NetworkMangerable {    
    func newRequest(api: APIable) async throws -> Data {
        guard let url = makeURL(api: api) else {
            throw APIError.urlError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method.string
        
        let result: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request) //추후에는 customDataTask에 dataTask를 data로 변경할 필요 있음
        
        guard let response = result.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw APIError.responseError
        }
        
        return result.data
    }
    
    private func makeURL(api: APIable) -> URL? {
        var component = URLComponents(string: api.host + api.path)
        
        component?.queryItems = api.params?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component?.url
    }
}
