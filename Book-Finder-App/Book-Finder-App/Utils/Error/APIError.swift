//
//  APIError.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

enum APIError: Error {
    case urlError
    case transportError
    case responseError
    case dataError
    case decodeError
    
    var errorDescription: String {
        return "서버 통신 중 오류가 발생했습니다(Error code: \(self))"
    }
}
