//
//  NetworkManger.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Alamofire

protocol NetworkMangerable {
    func ㄱequest<T: Decodable>(api:APIable, resultType: T.Type) async throws -> T
}

struct NetworkManger: NetworkMangerable {
    func request<T: Decodable>(api:APIable, resultType: T.Type) async throws -> T {
        let baseURL = api.host + api.path
        let request = AF.request(baseURL, method: api.method, parameters: api.params)
        let dataTask = request.serializingDecodable(resultType)
        
        switch await dataTask.result {
        case .success(let value):
            guard let response = await dataTask.response.response, (200...299).contains(response.statusCode) else {
                throw APIError.responseError
            }
            
            return value
        case .failure:
            throw APIError.transportError
        }
    }
}
