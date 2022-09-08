//
//  Error + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

extension Error {
    var errorMessage: String {
        guard let error = self as? APIError else {
            return "알 수 없는 오류가 발생했습니다\n서비스 센터로 연락 부탁드립니다(02-0000-0000)"
        }
        return error.errorDescription
    }
}
