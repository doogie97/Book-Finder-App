//
//  URLSessionProtorol.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/09.
//

import Foundation

struct ResponseResult {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

protocol URLSessionProtocol {
    func customDataTask(request: URLRequest, completion: @escaping (ResponseResult) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func customDataTask(request: URLRequest, completion: @escaping (ResponseResult) -> Void) -> URLSessionDataTask {
        let dataTask = self.dataTask(with: request) { data, response, error in
            let responseResult = ResponseResult(data: data, response: response, error: error)
            completion(responseResult)
        }
        
        return dataTask
    }
}
