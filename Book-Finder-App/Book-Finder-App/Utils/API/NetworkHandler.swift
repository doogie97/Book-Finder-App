//
//  NetworkHandler.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import RxSwift
import Foundation

struct NetworkHandler {
    private let session = URLSession.shared
    private let baseURL = "https://www.googleapis.com/books/v1/volumes/"
    
    func request(api: APIable) throws -> Observable<Data> {
        guard let url = makeURL(api: api) else {
            throw APIError.urlError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method.string
        
        return Observable<Data>.create() { emitter in
            let dataTask = session.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        emitter.onError(APIError.transportError)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                        emitter.onError(APIError.responseError)
                        return
                    }

                    guard let data = data else {
                        emitter.onError(APIError.dataError)
                        return
                    }
                    
                    emitter.onNext(data)
            }
            dataTask.resume()
            
            return Disposables.create()
        }
    }
    
    private func makeURL(api: APIable) -> URL? {
        var component = URLComponents(string: baseURL)
        
        component?.queryItems = api.params?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component?.url
    }
}
