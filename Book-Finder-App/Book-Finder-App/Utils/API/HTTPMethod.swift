//
//  HTTPMethod.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

enum HTTPMethod {
    case get //추후 필요에 따라 추가적인 메서드 case 생성 가능성 있음
    
    var string: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
