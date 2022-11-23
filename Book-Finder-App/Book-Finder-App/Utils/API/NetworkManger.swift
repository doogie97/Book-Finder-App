//
//  NetworkManger.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Foundation

protocol NetworkMangerable {
    func request(api: APIable, completion: @escaping (Result<Data, APIError>) -> Void)
    func newRequest(api: APIable) async throws -> Data
}

struct NetworkManger: NetworkMangerable {
    private let session: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.session = urlSession
    }
    
    func request(api: APIable, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = makeURL(api: api) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method.string
        
        let dataTask = session.customDataTask(request: request) { result in
            DispatchQueue.main.async {
                guard result.error == nil else {
                    completion(.failure(APIError.transportError))
                    return
                }
                
                guard let response = result.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(APIError.responseError))
                    return
                }

                guard let data = result.data else {
                    completion(.failure(APIError.dataError))
                    return
                }
                
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
    
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
