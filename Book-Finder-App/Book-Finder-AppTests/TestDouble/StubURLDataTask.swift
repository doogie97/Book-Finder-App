//
//  StubURLDataTask.swift
//  Book-Finder-AppTests
//
//  Created by 최최성균 on 2022/09/09.
//

import Foundation
@testable import Book_Finder_App

final class StubURLSessionDataTask: URLSessionDataTask {
    var fakeResume: () -> Void = {}
    
    override func resume() {
        fakeResume()
    }
}
