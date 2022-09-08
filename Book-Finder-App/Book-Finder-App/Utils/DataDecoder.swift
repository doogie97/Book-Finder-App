//
//  DataDecoder.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Foundation

protocol DataDecoderable {
    func parse<T: Decodable>(data: Data, resultType: T.Type) throws -> T
}

struct DataDecoder: DataDecoderable {
    func parse<T: Decodable>(data: Data, resultType: T.Type) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(resultType, from: data)
            return decodedData
        } catch {
            throw APIError.decodeError
        }
    }
}
