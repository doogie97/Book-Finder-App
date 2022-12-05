//
//  NetworkManger.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Alamofire

protocol NetworkMangerable {
    func request<T: Decodable>(api:APIable, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

struct NetworkManger: NetworkMangerable {    
    func request<T: Decodable>(api:APIable, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
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
