//
//  TestAPIModel.swift
//  Book-Finder-AppTests
//
//  Created by 최최성균 on 2022/09/09.
//
import Foundation
@testable import Book_Finder_App

struct TestAPIModel: APIable {
    var bookTitle: String
    var host: String
    var path: String
    var params: [String : String]?
    var method: HTTPMethod
}
