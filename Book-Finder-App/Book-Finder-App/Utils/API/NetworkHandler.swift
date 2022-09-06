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
    
    func request(api: APIable, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = makeURL(api: api) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method.string
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(APIError.transportError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(APIError.responseError))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.dataError))
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    private func makeURL(api: APIable) -> URL? {
        var component = URLComponents(string: baseURL)
        
        component?.queryItems = api.params?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component?.url
    }
}
