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
}
