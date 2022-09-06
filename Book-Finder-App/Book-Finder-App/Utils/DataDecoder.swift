//
//  DataDecoder.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import Foundation

struct DataDecoder {
    func parse(data: Data) throws -> SearchResult {
        do {
            let decodedData = try JSONDecoder().decode(SearchResult.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodeError
        }
    }
}
