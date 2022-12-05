//
//  NetworkManger.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Alamofire

protocol NetworkMangerable {
    func request(api: APIable, completion: @escaping (Result<Data, APIError>) -> Void)
    func newRequest<T: Decodable>(api:APIable, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
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
    
    private func makeURL(api: APIable) -> URL? {
        var component = URLComponents(string: api.host + api.path)
        
        component?.queryItems = api.params?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component?.url
    }
}


//Alamofire
extension NetworkManger {
    func newRequest<T: Decodable>(api:APIable, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        let baseURL = api.host + api.path
        
        let request = AF.request(baseURL, method: api.method, parameters: api.params)
        
        request.responseDecodable(of: resultType) { result in
            guard result.error == nil else {
                completion(.failure(APIError.transportError))
                return
            }
            
            guard let response = result.response, (200...299).contains(response.statusCode) else {
                completion(.failure(APIError.responseError))
                return
            }
            
            guard let data = result.value else {
                completion(.failure(APIError.dataError))
                return
            }
            
            completion(.success(data))
        }
    }
}
